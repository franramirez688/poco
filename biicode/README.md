Biicode C/C++ dependency manager
=================================

How to use it?
---------------

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
        fenix/poco(develop): 0

You could also keep your `#include`'s like `"Poco/Foundation.h"` and `"Poco/Net/HTTPServerRequestImpl.h"` adding the include mapping configuration into the mentioned file:

    [includes]
        Poco/Net/*.h: fenix/poco/Net/include
        Poco/*.h: fenix/poco/Foundation/include

Program your code and build it: 

    > bii cpp:build # This command will build your project and the POCO dependencies


You can check [the examples/poco(develop) block](https://www.biicode.com/examples/examples/poco/develop) with some examples using *POCO C++ develop version* with biicode.
