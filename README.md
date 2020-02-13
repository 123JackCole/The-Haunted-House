The Haunted House
========================

The Haunted House is a text based game about an innocent family being tormented by a spirit named Bael.

---

## Installation

1. Clone the repository
2. Navigate your terminal directory inside of the cloned repo
3. Run bundle install
4. Type "rake start_game" to begin

---

## Controls

#### Help

This is the main command that you will be using. Help pulls up a menu that shows you all commands you can use. If you're ever confused or stuck, type help to see your options. Let's go through them together.

#### List rooms

Lists the rooms in the house. A useful command if you forgot the names of the rooms and are trying to move to a different room.

#### List family

Lists the members of your family that are currently alive. The less family members that are alive the stronger the spirits will be!

#### Where am I

Tells you which room you're in.

#### Check sanity

Tells you your current sanity. Sanity is an important mechanic in this game. All family members have sanity. Whenever a family member encounters a spirit they are attacked and their sanity decreases. If a family member's sanity reaches zero, they die and become a spirit themselves. If your sanity reaches zero, you lose. There are also opportunities to gain back sanity that you'll encounter along the way.

#### Move to ____

Attepts to move you to a room. Whenever you successfully move to a room all other family members and spirits move as well, so try to move as efficiently as possible!

#### Search

Searches your current room for anything important. You need to search rooms to unlock the haunted house's secrets.

---

## Technology Used

Ruby
ActiveRecord

---

## Contributing

I used a cool gem called [colorize](https://github.com/fazibear/colorize)

## Author

Jack Cole - [GitHub](https://github.com/123JackCole)

## License

This project is licensed under [MIT](https://en.wikipedia.org/wiki/MIT_License#References)

Copyright (c) <2020> <Jack Cole>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
