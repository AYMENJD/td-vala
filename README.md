# TDLib vala
[TDLib](https://github.com/tdlib/td) json interface (tdjson) for vala. 

## Using tdjson in vala
First you must [build TDLib](https://github.com/tdlib/td#building) on your machine. 

Then you need to link `libtdjson.so` shared library with your vala app/file.

### Example
Here is an example code of using TDJson in vala:
```vala
public static void log_callback(int num, string message){
    print("LOG: "+ message);
}

void main () {
    // We need a client id (aka instance id) to deal with TDLib. 
    int client_id = TDJsonApi.create_client_id();

    //  Disable default TDLib log stream
    string setLogResult = TDJsonApi.execute("{\"@type\": \"setLogStream\", \"log_stream\": {\"@type\": \"logStreamEmpty\"}}");
    print(setLogResult);
    print("\n");

    //  Set log callback 
    TDJsonApi.set_log_message_callback(1024, (TDJsonApi.log_message_callback_ptr) log_callback);

    //  Set TDLib log verbosity level to 1023 (log everything)
    TDJsonApi.execute("{\"@type\": \"setLogVerbosityLevel\", \"new_verbosity_level\": 1023}");
    
    TDJsonApi.send(client_id, "{\"@type\": \"getOption\", \"name\": \"version\"");
    print(TDJsonApi.receive(10));
}
```

#### Build example
> By default [TDLib build instructions](https://tdlib.github.io/td/build.html) installs TDLib in `td/tdlib`.

Using `valac`:
- If TDLib is installed on your home directory:
    ```bash
    export TDLIB_PATH=$HOME/td/tdlib
    export LD_LIBRARY_PATH=$TDLIB_PATH/lib
    valac --vapidir . --pkg tdjson -X -L$LD_LIBRARY_PATH -X -ltdjson -X -I$TDLIB_PATH/include example.vala
    ```

- If TDLib is installed in `/usr/local` (recommended):
    ```bash
    valac --vapidir . --pkg tdjson -X -ltdjson example.vala
    ```

##### Run
```bash
./example
```
