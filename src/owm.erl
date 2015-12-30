-module(owm).
-author("Brian Downs").
-version("0.1").

-export([current/1]).

-define(DEFAULT_ENCODING, json).
-define(DEFAULT_CTYPE, <<"application/json">>).
-define(BASE_URL(X), "http://api.openweathermap.org/data/2.5/" ++ X).

-type content_type() :: json | xml.
-type response()     :: {ok, Status::status_code(), Headers::headers(), Body::body()} |
                        {error, Status::status_code(), Headers::headers(), Body::body()} |
                        {error, Reason::reason()}.

%% provide the current weather with the provided location name
current(Location) when Location =/= [] ->
	asdf
	;

%% provide the current weather with the provided location coordinates
current({Lat = X, Lon = Y}) when X > 0, Y > 0->
	asdf
	;

%% will provide the current weather with the provided location ID
current(ID) when ID > 0 -> 
	asdf
	;
current(Zip) ->
	asdf
	.

%% provide a forecast for the location given for the number of days given
forecast(Location,Days) when Location =/= [] -> 
	asdf
	;

%% will provide a forecast for the coordinates ID give for the number of days given
forcast({Lat = X, Lon = Y},Days) ->
	asdf
	;

%% will provide a forecast for the location ID give for the number of days given.
forecast(ID,Days) ->
	asdf
	.

%% return the history for the provided location
history(Location) when Location =/= [] ->
	asdf
	;

%% return the history for the provided location ID
history(ID) ->
	asdf
	.

%% gets the current UV data for the given coordinates
current_uv() -> 
	asdf
	.

%% gets the historical UV data for the coordinates and times
historical_uv() ->
	asdf
	.

%% make the request to the given OpenWeatherMap endpoint
request(Method, URL) ->
	inets:start(httpc, [{profile, owm}]),
    httpc:request(Method, {URL, []}, [], [{sync, false}]),
    inets:stop(httpc, owm).

build_url(Url, []) -> Url;
build_url(Url, Args) ->
    Url ++ "?" ++ lists:concat(
        lists:foldl(
            fun (Rec, []) -> [Rec]; (Rec, Ac) -> [Rec, "&" | Ac] end, [],
            [K ++ "=" ++ url_encode(V) || {K, V} <- Args]
        )
    ).

url_encode([]) -> [];
url_encode([H|T]) ->
    if
        H >= $a, $z >= H ->
            [H|url_encode(T)];
        H >= $A, $Z >= H ->
            [H|url_encode(T)];
        H >= $0, $9 >= H ->
            [H|url_encode(T)];
        H == $_; H == $.; H == $-; H == $/; H == $: ->
            [H|url_encode(T)];
        true ->
            case integer_to_hex(H) of
                [X, Y] ->
                    [$%, X, Y | url_encode(T)];
                [X] ->
                    [$%, $0, X | url_encode(T)]
            end
     end.