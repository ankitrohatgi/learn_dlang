import std.stdio;
import std.json;
import std.file;

void main()
{
    // Read entire file
    string jsonText = readText("test.json");
    writeln(jsonText);

    // Parse JSON
    JSONValue json = parseJSON(jsonText);
    writeln(json.toString());
    writeln(json.object["c"].array[0].type);
    writeln(json.object["c"].array[1].type);
    writeln(json.object["c"].type);
    writeln(json.type);
    writeln(json.object["c"].array[0].str);
}
