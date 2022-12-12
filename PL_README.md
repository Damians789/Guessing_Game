# Gra w zgadywanie
Gra w zgadywanie posiadająca tablicę wyników oraz możliwość rozgrywki z komputerem. Program został stworzony w celu zbadania najlepszego algorytmu do użycia
Guessing game with leaderboard and the ability to play vs computer. The program was used to measure the best algorithm for the case

 
Spis treści
Opracowanie projektu Zgadywanie	1
Główne założenia programu	1
Opis podstawy/główny	2
Trudne momenty/Ciekawe miejsca w kodzie/Trudności	7
Wyniki pomiarów/obliczeń/symulacji	8
Wnioski	8
Poszczególne fragmenty kodu	9


Główne założenia programu

Program w zgadywanie ma umożliwić przeprowadzenie gry z człowiekiem. Główne założenia:
1.	Gracz wybiera przedział liczb [Od: Do].
2.	Program sprawdza wprowadzone dane i jeżeli są poprawne to losuje liczbę.
3.	Gracz próbuje odgadnąć wylosowaną przez komputer liczbę z przedziału wybranego przez użytkownika.
4.	W dowolnym momencie gracz może podać „koniec” by zakończyć rozgrywkę.
5.	Po udanym strzale wyświetla się informacja o wyniku komputera, gracz podaję swoją nazwę oraz następuje zapytanie czy ponowić rozgrywkę, zakończyć lub podać tabelę wyników z pliku.
6.	Jeżeli gracz pobił swój personalny lub globalny rekord wyświetla się stosowny komunikat. 
Opis podstawy/główny

Program ma za zadanie przeprowadzić sesję gry w zgadywanie liczby i porównać wyniki z pozostałymi graczami. W rozgrywce bierze udział również komputer, który w tle próbuje odgadnąć wylosowaną liczbę za pomocą wyszukiwania binarnego. Bierze on środkową liczbę z wyznaczonego przedziału, następnie sprawdza czy jest ona niższa, czy wyższa od szukanej liczby i kontynuuje poszukiwania w kolejnej części, dopóki nie trafi na właściwą. Podczas gier użytkownik ma szansę na opracowanie najlepszego sposobu na odgadnięcie liczby w określonym przedziale za pomocą jak najmniejszej ilości kroków. Po uruchomieniu wygląda on następująco:

![obraz](https://user-images.githubusercontent.com/92166393/207167844-7adeb6da-bc6f-4fda-8df9-d02c197c0a41.png)


By rozpocząć należy wprowadzić przedział liczb [Od: Do] oddzielony spacją, po którym następuje szereg walidacji wprowadzonych danych.

 ![obraz](https://user-images.githubusercontent.com/92166393/207168400-20be107c-044f-4c5f-9ef2-a804a11ea261.png)


Po udzieleniu odpowiedzi otrzymujemy komunikat, by celować wyżej bądź niżej, aż uda nam się trafić poprawnie. Następnie użytkownik proszony jest o wprowadzenie swojej nazwy.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168684-3be1fdf7-9b97-4a3b-a107-0c641949d459.png)

Zapisywane jest pierwszych siedem znaków i następnie wyświetlane jest porównanie naszych ruchów z komputerem, w tym ustalenie zwycięzcy pojedynku oraz pytanie o dalsze instrukcje. Do wyboru jest kontynuacja rozgrywki, zakończenie lub wyświetlenie wyników. Jeżeli gracz stosował jakąś metodę, może ją również zapisać w celu późniejszej analizy.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168701-0a7dedbb-7909-4cb9-ba5c-194027daac28.png)

Gdy uda nam się pobić swój rekord lub też ten globalny otrzymamy odpowiedni komunikat.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168722-c4b66230-a8c0-4677-922b-85fa52e8c470.png)

Po zakończeniu rozgrywki ukazuję się nam lista, na której szczycie, znajdującej się w pliku w formacie yaml, znajdują się ex aequo gracze z najlepszym wynikiem.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168735-2973ffec-8933-489a-a343-3cb9fabb5dee.png)

Trudne momenty/Ciekawe miejsca w kodzie/Trudności

Jedną z trudniejszych rzeczy dla mnie było odpowiednie ulokowanie danych i późniejsze ich pobieranie. Dane są zapisywane częściowo w różnych funkcjach, do których potrzebują dostęp.
Sanityzacja inputu użytkownika przy jednoczesnym zachowaniu/rozszerzeniu możliwości wyjścia z programu poprzez podanie słowa kluczowego „koniec” oraz podanie decyzji po zakończeniu rozgrywki również nie była dla mnie oczywista.
Rozszerzenie programu o grę komputera, ustalenie optymalnego algorytmu odgadywania dla niego – binarne wyszukiwanie - oraz zapisywanie danych o danej rozgrywce z określonym graczem.
 
Wyniki pomiarów/obliczeń/symulacji

 
![obraz](https://user-images.githubusercontent.com/92166393/207168759-80039ad6-588a-4a28-8d42-e95f43d6cb2f.png)

Wnioski

Niełatwo jest zintegrować poszczególne części jednego programu. Należy go również pisać od początku w taki sposób, by ułatwić ewentualne późniejsze rozszerzenie go bez nadmiaru pracy.
Najlepszą metodą prowadzącą do odkrycia liczby z danego przedziału jest przeszukiwanie binarne, w którym dzieli się przedział na dwie połowy i sprawdza czy środkowy element jest tym szukanym, jeżeli nie to sprawdza czy jest on większy/mniejszy i kontynuuje. Wyniki komputera są porównywalne z użytkownikiem. 
Poszczególne fragmenty kodu

Dane są przechowywane w tzw. Hash’ach, gdzie każdy klucz jest unikalny, więc nie ma problemu, że jakiś użytkownik będzie miał więcej niż jeden zapis w danym momencie. Po zakończonej rozgrywce zapisywane są do plików z rozszerzeniem YAML. Gdy plików nie ma jeszcze utworzonych, to tworzona jest nowa dynamicznie alokowana przestrzeń w pamięci potrzebna na dane rozgrywki.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168780-d11ee591-d8f8-4bb1-952a-5ab444cca712.png)

Poprawnie oddany strzał mieści się w obrębie dolnej i górnej granicy wylosowanej liczby. Powinna to być pojedyncza liczba.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168789-dfbe5441-68b7-4fd0-8826-24c4f40c362e.png)

Komputer rozgrywa swoją partię w tle. Stosuje metodę wyszukiwania binarnego poprzez wybranie liczby ze środka wyznaczonego przedziału. Jeżeli jest ona wyższa od szukanej liczby podanej w argumencie funkcji, to ustawia ją jako górną granicę lub dolną+1, gdy jest ona niższa.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168797-dd85e836-3afb-4176-b580-abdb4c0e7f02.png)

Tablica wyników jest sortowana względem liczby prób danego użytkownika i następnie wyświetlana za pomocą podwójnej pętli.

 
![obraz](https://user-images.githubusercontent.com/92166393/207168804-4a44dea5-0539-4155-87a5-bc38295bfb17.png)

