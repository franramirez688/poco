# POCO C++ Libraries

[![Build Status](https://webapi.biicode.com/v1/badges/fenix/fenix/poco/v1.4.7p1)](https://www.biicode.com/fenix/fenix/poco/v1.4.7p1)


## How to use it?

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
    fenix/poco(v1.4.7p1): 0

You could also keep your `#include`'s like `"Poco/Foundation.h"` and `"Poco/Net/HTTPServerRequestImpl.h"` adding the include mapping configuration into the mentioned file:

    [includes]
    Poco/Net/*.h: fenix/poco/Net/include
    Poco/*.h: fenix/poco/Foundation/include

Program your code and build it: 

    > bii cpp:build # This command will build your project and the POCO dependencies


You can check [the block examples/poco(v1.4.7p1)](https://www.biicode.com/examples/examples/poco/v1.4.7p1) with some examples using POCO C++, 1.4.7p1 version, with biicode.


## DOCUMENTATION

Plenty of documentation (tutorial slides, articles and SDK reference)
is available at <http://pocoproject.org/documentation/>.


## MORE INFORMATION

For more information, see the POCO C++ Libraries website
at <http://pocoproject.org>.

	$Id: //poco/1.4/dist/README#5 $
