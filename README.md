POCO C++ Libraries [![Build Status](https://travis-ci.org/pocoproject/poco.png?branch=develop)](https://travis-ci.org/pocoproject/poco) [![Build Status](https://webapi.biicode.com/v1/badges/fenix/fenix/poco/v1.6.0)](https://www.biicode.com/fenix/fenix/poco/v1.6.0) 
==================

POrtable COmponents C++ Libraries are:
--------------------------------------
- A collection of C++ class libraries, conceptually similar to the Java Class Library, the .NET Framework or Apple’s Cocoa.
- Focused on solutions to frequently-encountered practical problems.
- Focused on ‘internet-age’ network-centric applications.
- Written in efficient, modern, 100% ANSI/ISO Standard C++.
- Based on and complementing the C++ Standard Library/STL.
- Highly portable and available on many different platforms.
- Open Source, licensed under the Boost Software License.

----
To start using POCO, see the [Guided Tour](http://pocoproject.org/docs-1.5.3/00100-GuidedTour.html) and [Getting Started](http://pocoproject.org/docs-1.5.3/00200-GettingStarted.html) documents.

----
POCO has an active user and contributing community, please visit our [web site](http://pocoproject.org), [forum](http://pocoproject.org/forum) and [blog](http://pocoproject.org/blog). 
Answers to POCO-related questions can also be found on [Stack Overflow](http://stackoverflow.com/questions/tagged/poco-libraries).

----
In regards to Boost, in spite of some functional overlapping,
POCO is best thought of as a Boost complement (rather than replacement).
Side-by-side use of Boost and POCO is a very common occurence.

When contributing to POCO, please adhere to our [coding styleguide](http://www.appinf.com/download/CppCodingStyleGuide.pdf).

We use the branching model described [here](http://nvie.com/posts/a-successful-git-branching-model/).

All text file line endings in the repository must be Unix-style (LF).
This includes Visual Studio project and solution files (.sln, .vcproj, .vcxproj, .vcxproj.filters).


How to use it?
------------------

New with biicode? Check the [getting started guide](http://docs.biicode.com/c++/gettingstarted.html).

Create new biicode project and create an empty block:
    
    > bii init myproject
    > bii new myuser/myblock


Include the header you need from this block into your source code, for example:

    #include "fenix/poco/Net/include/Poco/Net/HTTPServerRequestImpl.h"
    #include "fenix/poco/Foundation/include/Poco/Foundation.h"

Open **biicode.conf** file and write a *[requirements]* section to this block:

    [requirements]
        # This file contains your block external dependencies references
        fenix/poco(v1.6.0): 0

You could also keep your `#include`'s like `"Poco/Foundation.h"` and `"Poco/Net/HTTPServerRequestImpl.h"` adding the include mapping configuration into the mentioned file:

    [includes]
        Poco/Net/*.h: fenix/poco/Net/include
        Poco/*.h: fenix/poco/Foundation/include

Program your code and build it: 

    > bii cpp:build # This command will build your project and the POCO dependencies


You can check [the examples/poco(v1.6.0) block](https://www.biicode.com/examples/examples/poco/v1.6.0) with some examples using *POCO C++ 1.6.0 version* with biicode.
