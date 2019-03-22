# GameBook

This is a super old project that I collaborated on with my friend Mike. It was a choose-your-own-adventure interactive e-book for iPad where you played the role of a helper robot that awoke after many many years to a post-apocolyptic world. You would then commence having many wild and exciting adventures.  

Looking back, I'm pretty proud of this project for several reasons.  

For one, I created a view transition protocol to enable users to transition between views in an interactive fasion. A year or two later, Apple came out with their interactive view transition protocols and helper classes that worked very similarly. It felt good to know that my intuition was good and that I was on the right track with my thinking about a good way to approach the problem.  

Another thing I'm proud of is the DSL I came up with (in Lua!) to allow content creators to write stories with scripts to indicate the interactive parts of the pictures and game choices interspersed within the prose of the story. I was able to successfully embed the Lua runtime (using [Wax](https://github.com/probablycorey/wax)) and create an easy to use DSL that was expressive and flexible.  
I also modified the hell out of a framework called [Leaves](https://github.com/brow/leaves) that reproduced Apple's (then) private page-turn fuctionality in order to have the pages turn interactively and transition between two views. (Much like the swipe-to-go-back gesture in a navigation controller works today but, with a cool page-turn animation!)

The story, concepts, and artwork that Mike came up with are great too.

There are of course things that make me cringe a bit but, all-in-all, very proud of us and what we accomplished with this.
