// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/time;

public type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
|};

public type BuildingOptionalized record {|
    string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type BuildingWithRelations record {|
    *BuildingOptionalized;
    WorkspaceOptionalized[] workspaces?;
|};

public type BuildingTargetType typedesc<BuildingWithRelations>;

public type BuildingInsert Building;

public type BuildingUpdate record {|
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type Workspace record {|
    readonly string workspaceId;
    string workspaceType;
    string locationBuildingCode;
    string employeeEmpNo;
|};

public type WorkspaceOptionalized record {|
    string workspaceId?;
    string workspaceType?;
    string locationBuildingCode?;
    string employeeEmpNo?;
|};

public type WorkspaceWithRelations record {|
    *WorkspaceOptionalized;
    BuildingOptionalized location?;
    EmployeeOptionalized employee?;
|};

public type WorkspaceTargetType typedesc<WorkspaceWithRelations>;

public type WorkspaceInsert Workspace;

public type WorkspaceUpdate record {|
    string workspaceType?;
    string locationBuildingCode?;
    string employeeEmpNo?;
|};

public type Department record {|
    readonly string deptNo;
    string deptName;
|};

public type DepartmentOptionalized record {|
    string deptNo?;
    string deptName?;
|};

public type DepartmentWithRelations record {|
    *DepartmentOptionalized;
    EmployeeOptionalized[] employees?;
|};

public type DepartmentTargetType typedesc<DepartmentWithRelations>;

public type DepartmentInsert Department;

public type DepartmentUpdate record {|
    string deptName?;
|};

public type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    string gender;
    time:Date hireDate;
    string departmentDeptNo;
    string orderitemOrderId;
    string orderitemItemId;
|};

public type EmployeeOptionalized record {|
    string empNo?;
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    string gender?;
    time:Date hireDate?;
    string departmentDeptNo?;
    string orderitemOrderId?;
    string orderitemItemId?;
|};

public type EmployeeWithRelations record {|
    *EmployeeOptionalized;
    DepartmentOptionalized department?;
    WorkspaceOptionalized workspace?;
    OrderItemOptionalized orderItem?;
|};

public type EmployeeTargetType typedesc<EmployeeWithRelations>;

public type EmployeeInsert Employee;

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    string gender?;
    time:Date hireDate?;
    string departmentDeptNo?;
    string orderitemOrderId?;
    string orderitemItemId?;
|};

public type OrderItem record {|
    readonly string orderId;
    readonly string itemId;
    int quantity;
    string notes;
|};

public type OrderItemOptionalized record {|
    string orderId?;
    string itemId?;
    int quantity?;
    string notes?;
|};

public type OrderItemWithRelations record {|
    *OrderItemOptionalized;
    EmployeeOptionalized employee?;
|};

public type OrderItemTargetType typedesc<OrderItemWithRelations>;

public type OrderItemInsert OrderItem;

public type OrderItemUpdate record {|
    int quantity?;
    string notes?;
|};

