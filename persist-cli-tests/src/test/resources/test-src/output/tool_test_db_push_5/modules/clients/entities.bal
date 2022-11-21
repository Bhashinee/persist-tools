import ballerina/persist;
import ballerina/time;

@persist:Entity {
    key: ["fooNeedId"],
    tableName: "MedicalNeeds"
}
public type MedicalNeed record {|
    @persist:AutoIncrement
    readonly int fooNeedId = -1;

    int fooItemId;
    int fooBeneficiaryId;
    time:Civil period;
    int urgency;
    int foo;
|};

