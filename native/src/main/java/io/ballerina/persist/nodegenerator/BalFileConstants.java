/*
 *  Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.persist.nodegenerator;

/**
 * Class encapsulating all the syntax/code lines related to generation scripts.
 *
 * @since 0.1.0
 */
public class BalFileConstants {

    private BalFileConstants() {

    }
    public static final String ENTITIES = "entities";
    public static final String PERSIST_CLIENT = "persistClient";
    public static final String RETURN_RECORD_VARIABLE = "return {%s};";
    public static final String RETURN_VARIABLE = "return %s;";
    public static final String RETURN_TRUE = "return true;";
    public static final String RETURN_FALSE = "return false;";
    public static final String CLOSE_RECORD_VARIABLE = "record {|%s|}";
    public static final String DOUBLE_QUOTE = "\"";
    public static final String SINGLE_QUOTE = "\'";
    public static final String EMPTY_STRING = "";
    public static final String RETURN_VALUE = "return value;";
    public static final String ANYDATA_STREAM = "anydataStream";
    public static final String RETURN_NEXT_RECORD = "return nextRecord;";
    public static final String LAST_RETURN_ID_NULL_CHECK = "result.lastInsertId is ()";
    public static final String VALUE_TYPE_CHECK = "value[\"%s\"] is %s";
    public static final String GET_NEW_CLIENT = "%sClient %sClient = check new %sClient();";
    public static final String CHECK_EXISTENCE = "boolean exists = check %sClient->exists(<%s> value.%s);";
    public static final String NOT_EXIST = "!exists";
    public static final String CREATE_CLIENT = "value.%s = check %sClient->create(<%s> value.%s);";
    public static final String RETURN_VAUE = "return value;";
    public static final String RETURN_RESULT = "return result;";
    public static final String ENTITY_RELATIONS_ARRAY = "%sRelations[]";
    public static final String INCLUDE = "include";
    public static final String KEY = "key";
    public static final String VALUE = "value";
    public static final String FILTER = "filter";
    public static final String PERSIST = "persist";
    public static final String FIELD_FORMAT_WITH_AUTO_G = "{columnName: \"%s\", 'type: %s, autoGenerated: %s}";
    public static final String FIELD_FORMAT_WITHOUT_AUTO_G = "{columnName: \"%s\", 'type: %s}";
    public static final String FIELD_FORMAT_RELATED_CHILD_FIELD = "{'type: %s, relation: {entityName: \"%s\"," +
            " refTable: \"%s\", refField: \"%s\"}}";

    public static final String FIELD_FORMAT_JOIN_FIELD =
            "{entity: %s, fieldName: \"%s\", refTable: \"%s\", refFields: [\"%s\"], joinColumns: [\"%s\"]}";
    public static final String FIELD_FORMAT_RELATED_PARENT_FIELD = "{columnName: \"%s\", 'type: %s, relation: " +
            "{entityName: \"%s\", refTable: \"%s\", refField: \"%s\"}}";
    public static final String FIELD_FORMAT_RELATED_PARENT_FIELD_WOUT_COLUMN_NAME = "{'type: %s, relation: " +
            "{entityName: \"%s\", refTable: \"%s\", refField: \"%s\"}}";
    public static final String ERROR = "error";
    public static final String TYPE_FIELD_METADATA_MAP = "map<persist:FieldMetadata>";
    public static final String TYPE_JOIN_METADATA_MAP = "map<persist:JoinMetadata>";
    public static final String TAG_FIELD_METADATA = "fieldMetadata";
    public static final String TAG_JOIN_METADATA = "joinMetadata";
    public static final String INIT_MYSQL_CLIENT = "mysql:Client dbClient = check new (host = host, user = user," +
            " password = password, database = database, port = port);";
    public static final String INIT_PERSIST_CLIENT = "self.persistClient = check new (dbClient, self.entityName, " +
            "self.tableName, self.keyFields, self.fieldMetadata);";
    public static final String INIT_PERSIST_CLIENT_RELATED = "self.persistClient = check " +
            "new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata, self.joinMetadata);";
    public static final String CREATE_SQL_RESULTS = "sql:ExecutionResult result = check " +
            "self.persistClient.runInsertQuery(value);";
    public static final String READ_BY_KEY_RETURN = "return (check self.persistClient" +
            ".runReadByKeyQuery(%s, key)).cloneWithType(%s);";
    public static final String READ_BY_KEY_RETURN_RELATION = "return <%s> check " +
            "self.persistClient.runReadByKeyQuery(%s, key, include);";
    public static final String READ_RUN_READ_QUERY = "stream<anydata, error?>|error result" +
            " = self.persistClient.runReadQuery(%s, ());";
    public static final String EXECUTE_RUN_EXECUTE_QUERY = "stream<anydata, error?>|error result" +
            " = self.persistClient.runExecuteQuery(filterClause, %s);";
    public static final String READ_RUN_READ_QUERY_RELATED = "stream<anydata, error?>|error result" +
            " = self.persistClient.runReadQuery(%s, (), include);";
    public static final String READ_RETURN_STREAM_WHEN_ERROR = "return new stream<%s, error?>" +
            "(new %sStream((), result));";
    public static final String READ_RETURN_STREAM_WHEN_NOT_ERROR = "return new stream<%s, error?>" +
            "(new %sStream(result));";
    public static final String UPDATE_RUN_UPDATE_QUERY = "_ = check self.persistClient.runUpdateQuery" +
            "(value, filter);";
    public static final String DELETE_RUN_DELETE_QUERY = "_ = check self.persistClient.runDeleteQuery(value);";
    public static final String CLOSE_PERSIST_CLIENT = "return self.persistClient.close();";
    public static final String INIT_STREAM_STATEMENT = "self.anydataStream = anydataStream;";
    public static final String NEXT_STREAM_RETURN_TYPE = "record {|%s value;|}|error?";

    public static final String NEXT_STREAM_IF_STATEMENT = "streamValue is ()";
    public static final String NEXT_STREAM_ELSE_IF_STATEMENT = "(streamValue is error)";
    public static final String NEXT_STREAM_RETURN_STREAM_VALUE = "return streamValue;";
    public static final String NEXT_STREAM_ELSE_STATEMENT = "record {|%s value;|} nextRecord = " +
            "{value: check streamValue.value.cloneWithType(%s)};";
    public static final String CLOSE_STREAM_STATEMENT = "return anydataStream.close();";

    public static final String CONFIGURABLE_PORT = "configurable int port = ?;";
    public static final String CONFIGURABLE_HOST = "configurable string host = ?;";
    public static final String CONFIGURABLE_USER = "configurable string user = ?;";
    public static final String CONFIGURABLE_PASSWORD = "configurable string password = ?;";
    public static final String CONFIGURABLE_DATABASE = "configurable string database = ?;";
    public static final String INIT = "init";
    public static final String READ = "read";
    public static final String CREATE = "create";
    public static final String DELETE = "delete";
    public static final String EXISTS = "exists";
    public static final String READ_BY_KEY = "readByKey";
    public static final String UPDATE = "update";
    public static final String CLOSE = "close";
    public static final String NEXT = "next";

    public static final String RECORD_FIELD_VAR = "%s:%s";
    public static final String RECORD_FIELD_LAST_INSERT_ID = "%s: <%s>result.lastInsertId";
    public static final String RECORD_FIELD_VALUE = "%s: value.%s";
    public static final String KEYWORD_BALLERINA = "ballerina";
    public static final String KEYWORD_BALLERINAX = "ballerinax";
    public static final String KEYWORD_PRIVATE = "private";
    public static final String KEYWORD_CLIENT = "client";
    public static final String KEYWORD_PUBLIC = "public";
    public static final String KEYWORD_ISOLATED = "isolated";
    public static final String KEYWORD_FINAL = "final";
    public static final String KEYWORD_REMOTE = "remote";
    public static final String KEYWORD_INT = "int";
    public static final String KEYWORD_STRING = "string";
    public static final String KEYWORD_SQL = "sql";
    public static final String KEYWORD_MYSQL = "mysql";
    public static final String KEYWORD_TIME = "time";
    public static final String ENTITY = "Entity";
    public static final String RELATION = "Relation";
    public static final String REFERENCE = "reference";
    public static final String KEY_COLUMNS = "keyColumns";

    public static final String ENUM_NAME = "%sRelations";

    public static final String RECORD_CHECK = "value[\"%s\"] is record {}";
    public static final String GET_ENTITY_RECORD = "record {} %sEntity = <record {}> value[\"%s\"];";
    public static final String GET_ENTITY_CLIENT = "%sClient %sClient = check new %sClient();";
    public static final String GET_ENTITY_STREAM = "stream<%s, error?> %sStream = " +
            "self->read([%sEntity]);";
    public static final String EXIST_READ_BY_KEY = "%s|error result = self->" +
            "readByKey(%s);";
    public static final String EXIST_CHECK_INVALID = "result is persist:InvalidKeyError";
    public static final String CHECK_RESULT = "result is %s";
    public static final String ENUM_ENTRY = "%sEntity = \"%s\"";
    public static final String JDBC_URL_WITHOUT_DATABASE = "jdbc:%s://%s:%s";
    public static final String JDBC_URL_WITH_DATABASE = "jdbc:%s://%s:%s/%s";

    public static final String CHECK_QUERY_ACTION = "from %s p in %sStream\n" +
            "                do {\n" +
            "                    if p.%s is %s {\n" +
            "                        check %sClient->update(<%s> %sEntity);\n" +
            "                    }\n" +
            "                }";
    public static final String ANYDATA_STREAM_STATEMENT = "private stream<anydata, error?>? anydataStream;";
    public static final String NULLABLE_ERROR_STATEMENT = "private error? err;";
    public static final String SELF_ERR = "self.err = err;";

    public static final String ANYDATA_KETWORD = "anydataStream";

    public static final String ERR_IS_ERROR = "self.err is error";
    public static final String RETURN_CASTED_ERROR = "return <error>self.err;";
    public static final String ANYDATASTREAM_IS_STREAM_TYPE = "self.anydataStream is stream<anydata, error?>";
    public static final String CAST_ANYDATA_STREAM = "var anydataStream = <stream<anydata, error?>>self.anydataStream;";
    public static final String ANYDATA_STREAM_NEXT = "var streamValue = anydataStream.next();";
    public static final String RESULT_IS_ERROR = "result is error";
}
