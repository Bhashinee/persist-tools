import ballerina/persist as _;
import ballerinax/persist.sql;

public enum UserGender {
    MALE = "MALE",
    FEMALE = "FEMALE"
}

public type User record {|
    readonly string email;
    readonly string nic;
    string name;
    UserGender gender;
    decimal? salary;
    Car[] cars;
|};

public type Car record {|
    readonly int id;
    string name;
    string model;
    @sql:Index {names: ["ownerEmail"]}
    string ownerEmail;
    @sql:Index {names: ["ownerEmail"]}
    string ownerNic;
    @sql:Relation {refs: ["ownerEmail", "ownerNic"]}
    User user;
|};

