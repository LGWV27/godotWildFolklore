# Mothman - Flight of Blair Mountain

This game was made for Godot Wild Jam #70 as a solo project with the theme "Folklore."

This is my second game jam, and definitely an improvement on my last (this one is technically an actual game). Still, don't go in expecting much - this game is very bare-bones, short, and simple.

## How to Play

Your goal is to climb Blair Mountain before the smoke and fire catch up with you and avoid dying from the "coal sprites" throughout the vertical level. Once you reach the top, deal with the coal magnate and save Blair Mountain.

- **Movement:** WASD
- **Jump (and double jump):** Space
- **Melee Attack:** E

### Achievements

- No damage taken
- Kill all enemies

## Description / Theme

Growing up in West Virginia, two of my favorite bits of history and folklore are the Battle of Blair Mountain and the Mothman. With this jam, I decided to poorly mash both of these things together into this submission.

When I first started brainstorming for this jam, I ended up thinking about arcade-style "beat-em-up" games and Doodle Jump.

Some of my main goals for this jam were to learn how to utilize autoloads, basic combat, and resource tracking (like health). I also ended up adding on stuff like learning how to build out a menu system, scene traversal, and instancing audio players for music/FX.

Overall, I'm really happy with actually implementing those new mechanics that I've never touched before. Looking back, my code started to lose its structure once I started adding to the health/combat system and quickly lost its object-oriented focus, causing repeated bits of code for things like damage activation. Part of this might also be that I still haven't gotten around to learning state machines, which has ended up causing a lot of spaghetti connections in my functions.

Anyway, I'm still nowhere near the level I want to be - but happy that there is some progress from my last jam entry. Looking forward to next month's jam!

## Credits

- **Art, Programming, Music, Game Design, Story, Midlife Crisis, Etc:** LGWV (that's me)

## Cutting Room Floor

Originally I had a much larger scope, as usual. This included 2 additional enemies, power-ups, additional attacks, and some voiced dialogue for the coal magnate at the top of the mountain.

- **Scrapped Attacks:**
  - **Light Beam / Moth Beam:** A long-range attack that was meant to go horizontal or diagonal depending on if the player was on a platform or midair. This would have allowed for dealing with the enemy mobs a bit easier, but I ended up having issues getting the long-range damage to actually work.

- **Baldwin–Felts Detective Agents:**
  - One variant armed with a club and one with a rifle. Originally, I wanted to include these two mobs - one would fire at you from range with a rifle while the other would attempt to jump after you, following the path you took on the platforms. This ended up mainly being a time issue and with figuring out how to deal with ranged damage.

Lastly, I made the game background art on the final day of the jam - I really wish I had given this a bit more time, as it is obviously rushed.
