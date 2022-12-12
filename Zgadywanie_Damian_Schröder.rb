require 'yaml'
require 'securerandom'

def pobranie()
  puts "\nPodaj przedział liczb, pomiędzy jakimi chcesz zgadywac lub koniec by wyjsc"
  begin
    puts "\nPodaj przedzial od do rozdzielony spacja"
    $x = gets.chomp
    gramy_dalej(decyzja2: $x)
    $x, $y = $x.split(' ').map(&:to_i)
    raise IndexError, "error" if $x > $y
  rescue IndexError
    puts "Podaj odpowiedni przedzial, wartosc 'od' musi byc mniejsza od 'do'"
    retry
  rescue ArgumentError
    p "Uzywaj wartosci liczbowych"
    retry
  else
    $x = $x.to_i
    $y = $y.to_i
  end

  return rand($x .. $y)
end

def check()
  begin
    traf = gets().chomp()
    gramy_dalej(decyzja2: traf)
    traf = Integer(traf)
    raise IndexError, "error" if traf < $x or traf > $y
  rescue IndexError
    print "Sprobuj zmiescic sie w wyznaczonym przedziale: ", $x, "..", $y, "\n"
    retry
  rescue ArgumentError
    p "Uzywaj wartosci liczbowych"
    retry
  else
    return traf.to_i
  end
end


def probuj(liczba)
  liczba_prob = 1
  strzaly = []
  print "\nPodaj liczbe z przedzialu: ", $x, "..", $y, "\n"
  traf = check()

  strzaly.append(traf)

  until traf == liczba do
    if traf > liczba
      puts "Sprobuj troche nizej"
    elsif traf < liczba
      puts "Celuj wyzej!"
    end
    traf = check()
    strzaly.append(traf)
    liczba_prob += 1
  end

  return liczba_prob, strzaly
end


def computer_guess(liczba)
  wy2 = Hash.new{ |h, k| h[k] = Hash.new(&h.default_proc) }
  wy2 = YAML.load(File.read("hall_of_fame_computers.yml"))
  sec = SecureRandom.alphanumeric
  nazwa = "Komputer" + sec
  wy2[nazwa] = {}
  wy2[nazwa]['do_odgadniecia'] = liczba
  prob = 1
  proby = []
  dol, gora = $x, $y
  traf = (dol+gora)/2
  proby.append(traf)

  until traf == liczba do
    traf = (dol+gora)/2
    if traf > liczba
      gora = traf
    elsif traf < liczba
      dol = traf + 1
    end
    proby.append(traf)
    prob += 1
  end

  wy2[nazwa]['strzaly'] = proby
  wy2[nazwa]['ilosc_prob'] = prob

  return wy2, nazwa
end


def wyswietl(wynick)
  print "Zawodnik\tProby\t\tCzas\t\t\t\t\tTrafiony\t\tStrzaly\n"
  wynick.sort_by{ |k, v| v["liczba_prob"]}.to_h.each do |key, value|
    print "", key
    value.each do |key2, value2|
      print "\t\t", value2
    end
    print "\n"
  end
end


def wyswietljeden(wy, n)
  print "\n\tDo odgadniecia\n\t\t", wy["do_odgadniecia"]
  print "\n\n\tKomputer\t", n
  print "\n\t\tStrzaly\n"
  print "\t", wy["strzaly"]
  print "\t", "\t", wy[n]["strzaly"]
  print "\n\n\t\tWynik\n\t"
  print wy["ilosc_prob"], "\tVS\t", wy[n]["liczba_prob"]
  print "\n\n>>>>>>>>>>>\t", wy["wynik"]["zwyciezca"], "\t<<<<<<<<<<<<<"
  print "\n"
end


def gramy_dalej(wynick: {}, decyzja2: "")
  if !decyzja2.empty?
    if decyzja2 == "koniec"
      puts "zegnaj"
      exit
    end
    return
  end

  puts "Czy gramy jeszcze raz? [T/N/R]"
  decyzja = gets().chomp().downcase
  until decyzja != "r"
    wyswietl(wynick)
    puts "Czy gramy jeszcze raz? [T/N/R]"
    decyzja = gets().chomp().downcase
    if decyzja == "koniec" or decyzja == 'n'
      puts "zegnaj"
    end
  end

  return decyzja
end




puts "Teraz będziesz zgadywać liczbę, którą wylosowałem"
decyzja = 'y'
zgadywane = []
strzaly = []
wy = Hash.new{ |h, k| h[k] = Hash.new(&h.default_proc) }
wy = YAML.load(File.read("hall_of_fame.yml"))
until decyzja == 'n' or decyzja == "koniec" do

  liczba = pobranie
  liczba_prob, strzaly = probuj(liczba)
  wy2, comp = computer_guess(liczba)

  print "\nUdalo Ci sie w #{liczba_prob} probach, podaj swoja nazwe: "
  nick = gets.chomp.strip[0,7]


  czas = Time.new
  najlepszy_wynik = 999.to_i
  wy.each do |k, v|
    if najlepszy_wynik > v['liczba_prob'].to_i
      najlepszy_wynik = v['liczba_prob'].to_i
    end
  end

  if wy.empty? or !wy.has_key? nick
    wy[nick] = {}
    wy[nick]['liczba_prob'] = liczba_prob
    wy[nick]['czas'] = czas.inspect
    wy[nick]['do_odgadniecia'] = liczba
    wy[nick]['strzaly'] = strzaly
  elsif wy[nick]['liczba_prob'].to_i > liczba_prob.to_i
    print "Brawo ", nick, " udalo Ci sie pobic Twoj obecny rekord: ", wy[nick]['liczba_prob'], "!\n"
    if liczba_prob.to_i <= najlepszy_wynik
      puts "Udalo Ci sie rowniez pobic/wyrownac wynik globalny!"
    end
    wy[nick]['liczba_prob'] = liczba_prob
    wy[nick]['czas'] = czas.inspect
    wy[nick]['do_odgadniecia'] = liczba
    wy[nick]['strzaly'] = strzaly
  end

  wy2[comp][nick] = {}
  wy2[comp][nick]['liczba_prob'] = liczba_prob
  wy2[comp][nick]['strzaly'] = strzaly
  wy2[comp]['wynik'] = {}
  if wy2[comp]['ilosc_prob'] > wy2[comp][nick]['liczba_prob']
    wy2[comp]['wynik']['zwyciezca'] = nick
    wy2[comp]['wynik']['roznica'] = (wy2[comp]['ilosc_prob'] - wy2[comp][nick]['liczba_prob'])
  elsif wy2[comp]['ilosc_prob'] < wy2[comp][nick]['liczba_prob']
    wy2[comp]['wynik']['zwyciezca'] = comp
    wy2[comp]['wynik']['roznica'] = (wy2[comp][nick]['liczba_prob'] - wy2[comp]['ilosc_prob'])
  else
    wy2[comp]['wynik']['zwyciezca'] = 'remis'
    wy2[comp]['wynik']['roznica'] = 0
  end

  File.open("hall_of_fame_computers.yml", "w") { |file| file.write(wy2.to_yaml) }

  wyswietljeden(wy2[comp], nick)
  zgadywane.append(liczba)
  print "\n"
  decyzja = gramy_dalej(wynick: wy)
end

File.open("hall_of_fame.yml", "w") { |file| file.write(wy.to_yaml) }
print "\nLiczby do odgadniecia wynosily: ", zgadywane, "\n"
wyswietl(wy)

