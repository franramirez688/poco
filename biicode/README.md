Biicode C/C++ dependency manager
=================================
New with biicode? Check the [getting started guide](http://docs.biicode.com/c++/gettingstarted.html).

How build it?
------------------
Building it is too easy:

    $ git clone git@github.com:pocoproject/poco.git
    $ cd poco
    $ bii buzz

It creates all the necessary structure to build POCO with biicode build system and try some selected examples.

By default, the first use applies all the changes to the repository, if you want to revert these ones, set the `BII_POCO_REVERT_CHANGES` environment variable to `True` and run `bii work` to keep your original code and undo the biicode changes.

    $ export BII_POCO_REVERT_CHANGES='True' # for Windows users: set BII_POCO_REVERT_CHANGES=True
    $ bii work


How use it in other projects?
----------------------------------
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
