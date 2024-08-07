public static void log_callback(int log_level, string message){
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
    
    TDJsonApi.send(client_id, "{\"@type\": \"getOption\", \"name\": \"version\"}");
    print(TDJsonApi.receive(10));
}
