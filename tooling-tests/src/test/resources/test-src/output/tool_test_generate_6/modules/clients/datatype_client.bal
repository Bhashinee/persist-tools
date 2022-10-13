import ballerina/sql;
import ballerinax/mysql;
import ballerina/time;
import ballerina/persist;

public client class DataTypeClient {

    private final string entityName = "DataType";
    private final sql:ParameterizedQuery tableName = `DataTypes`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        a: {columnName: "a", 'type: int, autoGenerated: true},
        b1: {columnName: "b1", 'type: string},
        c1: {columnName: "c1", 'type: int},
        d1: {columnName: "d1", 'type: boolean},
        e1: {columnName: "e1", 'type: float},
        f1: {columnName: "f1", 'type: decimal},
        j1: {columnName: "j1", 'type: time:Utc},
        k1: {columnName: "k1", 'type: time:Civil},
        l1: {columnName: "l1", 'type: time:Date},
        m1: {columnName: "m1", 'type: time:TimeOfDay},
        v1: {columnName: "v1", 'type: anydata}
    };
    private string[] keyFields = ["a"];

    private persist:SQLClient persistClient;

    public function init() returns error? {
        mysql:Client dbClient = check new (host = host, user = user, password = password, database = database, port = port);
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata);
    }

    remote function create(DataType value) returns DataType|error {
        sql:ExecutionResult result = check self.persistClient.runInsertQuery(value);
        return {a: <int>result.lastInsertId, b1: value.b1, c1: value.c1, d1: value.d1, e1: value.e1, f1: value.f1, j1: value.j1, k1: value.k1, l1: value.l1, m1: value.m1, v1: value.v1};
    }

    remote function readByKey(int key) returns DataType|error {
        return (check self.persistClient.runReadByKeyQuery(DataType, key)).cloneWithType(DataType);
    }

    remote function read() returns stream<DataType, error?> {
        stream<anydata, error?>|error result = self.persistClient.runReadQuery(DataType, ());
        if result is error {
            return new stream<DataType, error?>(new DataTypeStream((), result));
        } else {
            return new stream<DataType, error?>(new DataTypeStream(result));
        }
    }

    remote function execute(sql:ParameterizedQuery filterClause) returns stream<DataType, error?> {
        stream<anydata, error?>|error result = self.persistClient.runExecuteQuery(filterClause, DataType);
        if result is error {
            return new stream<DataType, error?>(new DataTypeStream((), result));
        } else {
            return new stream<DataType, error?>(new DataTypeStream(result));
        }
    }

    remote function update(DataType value) returns error? {
        map<anydata> filter = {"a": value.a};
        _ = check self.persistClient.runUpdateQuery(value, filter);
    }

    remote function delete(DataType value) returns error? {
        _ = check self.persistClient.runDeleteQuery(value);
    }

    function close() returns error? {
        return self.persistClient.close();
    }
}

public class DataTypeStream {

    private stream<anydata, error?>? anydataStream;
    private error? err;

    public isolated function init(stream<anydata, error?>? anydataStream, error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|DataType value;|}|error? {
        if self.err is error {
            return <error>self.err;
        } else if self.anydataStream is stream<anydata, error?> {
            var anydataStream = <stream<anydata, error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is error) {
                return streamValue;
            } else {
                record {|DataType value;|} nextRecord = {value: check streamValue.value.cloneWithType(DataType)};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns error? {
        if self.anydataStream is stream<anydata, error?> {
            var anydataStream = <stream<anydata, error?>>self.anydataStream;
            return anydataStream.close();
        }
    }
}

