//What menu we are currently on.
piloy = 0;

//This will store the server and client objects.
server = -1;
client = -1;

//Chooses a random name for the player.
randomize();
nickname = "player" + string(irandom(9999));
variable_global_set("nick", nickname);

//Sets the connection timeout to 10 seconds.
znet_set_timeout(10000);

