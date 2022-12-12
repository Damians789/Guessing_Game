Guessing_Game

Guessing game with leaderboard and the ability to play vs computer. The program was used to measure the best algorithm for the case

Table of Contents 
- Project development Guessing 1 
- Main assumptions of the program 1 
- Basic description / main 2
- Difficult moments / Points of interest in the code / Difficulties 7
- Measurement / calculation / simulation results 8
- Conclusions 8
- Individual code fragments 9

The main assumptions of the program

The guessing program is designed to allow you to play a game with a human. Main assumptions:

     The player chooses the number range [From: To].
     The program checks the entered data and if they are correct, it draws a number.
     The player tries to guess the number drawn by the computer from the range selected by the user.
     At any time, a player may enter "end" to end the game.
     After a successful shot, information about the computer's result is displayed, the player enters his name and is asked whether to retry the game, end it or provide a table of results from the file.
     If the player has beaten his personal or global record, an appropriate message is displayed. Base/main description

The program is designed to conduct a number guessing game session and compare the results with other players. The game also involves a computer, which in the background tries to guess the drawn number using a binary search. It takes the middle number from the designated range, then checks whether it is lower or higher than the searched number and continues the search in the next part until it finds the right one. During the games, the user has the chance to work out the best way to guess a number within a certain range with as few steps as possible. After launching it looks like this:

![obraz](https://user-images.githubusercontent.com/92166393/207169473-4dccdc00-3456-4b16-bc8a-7d045c2653f1.png)

To start, enter the range of numbers [From: To] separated by a space, followed by a series of validations of the entered data.

![obraz](https://user-images.githubusercontent.com/92166393/207169464-d7f7a727-08f3-4e06-a9da-0422c7717945.png)

After answering, we get a message to aim higher or lower until we manage to hit correctly. The user is then asked to enter their name.

![obraz](https://user-images.githubusercontent.com/92166393/207169449-e8847c00-1383-4400-ba71-b1eb75c0b2bd.png)

The first seven characters are saved and then a comparison of our moves with the computer is displayed, including determining the winner of the duel and asking for further instructions. You can choose to continue the game, end it or view the results. If the player used a method, they can also save it for later analysis.

![obraz](https://user-images.githubusercontent.com/92166393/207169437-54a801b0-bca3-4049-a383-e21210b86850.png)

When we manage to beat our record or the global one, we will receive an appropriate message.

![obraz](https://user-images.githubusercontent.com/92166393/207169423-11322a04-7615-43d1-8dee-39831b85ff6e.png)

After the end of the game, we see a list at the top of which, in the yaml file, there are ex aequo players with the best score.

![obraz](https://user-images.githubusercontent.com/92166393/207169407-751f0586-8133-45d9-afc4-ea264b6ea799.png)

Difficult moments/Interesting places in the code/Difficulty

One of the most difficult things for me was to properly locate the data and download it later. The data is saved partly in the various functions to which they need access. Sanitizing user input while maintaining/extending the possibility of exiting the program by entering the keyword "end" and giving a decision after the end of the game was also not obvious to me. Extending the program with a computer game, determining the optimal guessing algorithm for it - binary search - and saving data about a given game with a specific player. Results of measurements/calculations/simulations

![obraz](https://user-images.githubusercontent.com/92166393/207169390-bc5779aa-70ae-40c2-bf11-cacbc1006215.png)

Conclusions

It is not easy to integrate individual parts of one program. It should also be written from scratch in such a way as to facilitate possible future extensions without too much work. The best method to discover a number from a given range is a binary search, which divides the range into two halves and checks if the middle element is the one you are looking for, if not, it checks if it is greater/smaller and continues. The performance of the computer is comparable to the user. Individual pieces of code

The data is stored in the so-called Hashes, where each key is unique, so there is no problem that some user will have more than one record at a time. After the game is over, they are saved to files with the YAML extension. When the files are not yet created, a new dynamically allocated memory space is created for the gameplay data.

![obraz](https://user-images.githubusercontent.com/92166393/207169374-8ea34e56-0bff-4bd1-8c56-57502b3d7d27.png)

A correct shot is within the lower and upper limits of the drawn number. It should be a single number.

![obraz](https://user-images.githubusercontent.com/92166393/207169363-e0b98fc9-10ab-434b-b6ba-451016361e20.png)

The computer plays its game in the background. Applies a binary search method by selecting a number in the middle of the specified range. If it is higher than the search number given in the function argument, it sets it as the upper bound, or lower+1 if it is lower.

![obraz](https://user-images.githubusercontent.com/92166393/207169342-0ed444b3-f12d-462c-9b4c-92aab5309054.png)

The scoreboard is sorted by the user's number of attempts and then displayed using a double loop.

![obraz](https://user-images.githubusercontent.com/92166393/207169327-646a271f-b569-4153-896f-a5af9642675a.png)
