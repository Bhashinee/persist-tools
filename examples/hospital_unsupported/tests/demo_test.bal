// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/http;
import DemoUnsupported.entities;
import ballerinax/mysql;

http:Client hospitalEndpoint = check new("http://localhost:9090/hospital");
configurable int port = ?; 
configurable string host = ?;
configurable string user = ?;
configurable string database = ?;
configurable string password = ?;
configurable mysql:Options & readonly connectionOptions = {};

@test:BeforeSuite
function initDatabase() returns error? {
    mysql:Client dbClient = check new (host = host, user = user, password = password, port = port, options = connectionOptions);
    _ = check dbClient->execute(`DROP DATABASE IF EXISTS hospital`);
    _ = check dbClient->execute(`CREATE DATABASE hospital`);
    _ = check dbClient->execute(`USE hospital`);
    _ = check dbClient->execute(`CREATE TABLE Doctor (
	        id INT NOT NULL,
	        name VARCHAR(191) NOT NULL,
	        specialty VARCHAR(191) NOT NULL,
	        phone_number VARCHAR(191) NOT NULL,
	        salary DECIMAL(10,2),
            favDrinks SET('COFFEE', 'TEA', 'WATER'),
	        PRIMARY KEY(id)
      )`);
    _ = check dbClient->execute(`CREATE TABLE patients (
          ID INT AUTO_INCREMENT,
          name VARCHAR(191) NOT NULL,
          age INT NOT NULL,
          ADDRESS VARCHAR(191) NOT NULL,
          phoneNumber CHAR(10) NOT NULL,
          gender ENUM('MALE', 'FEMALE') NOT NULL,
          PRIMARY KEY(ID)
      )`);
    _ = check dbClient->execute(`CREATE TABLE appointment (
          id INT NOT NULL,
          reason VARCHAR(191) NOT NULL,
          appointmentTime DATETIME NOT NULL,
          status ENUM('SCHEDULED', 'STARTED', 'ENDED') NOT NULL,
          patient_id INT NOT NULL,
          FOREIGN KEY(patient_id) REFERENCES patients(ID),
          doctorId INT NOT NULL,
          FOREIGN KEY(doctorId) REFERENCES Doctor(id),
          PRIMARY KEY(id)
      )`);
      _ = check dbClient->execute(`INSERT INTO Doctor values 
        (1, "Doctor Mouse", "Physician", "077100100", 20000, "TEA,COFFEE");`);
    _ = check dbClient->execute(`CREATE INDEX patientId ON appointment (patient_id)`);
    _ = check dbClient->execute(`CREATE INDEX doctorId ON appointment (doctorId)`);
    _ = check dbClient->execute(`CREATE UNIQUE INDEX reason_index ON appointment (reason)`);
    _ = check dbClient->execute(`CREATE INDEX specialty_index ON Doctor (specialty)`);
    _ = check dbClient.close();
}

@test:Config{}
function testCreatePatient() returns error? {
    entities:PatientInsert patient = {
      name: "John Doe",
      age: 30,
      phoneNumber: "0771690000",
      gender: "MALE",
      address: "123, Main Street, Colombo 05"
    };
    http:Response result = check hospitalEndpoint->/patients.post(patient);
    test:assertEquals(result.statusCode, 201, "Status code should be 201");
    test:assertEquals(result.getJsonPayload(), {"insertedId":1}, "Inserted Patient ID should be 1");
}


@test:Config{
  dependsOn: [testCreatePatient]
}
function testCreateAppointment() returns error? {
    entities:AppointmentInsert appointment = {
      id: 1,
      patientId: 1,
      doctorId: 1,
      appointmentTime: {year: 2023, month: 7, day: 1, hour: 10, minute: 30},
      status: "SCHEDULED",
      reason: "Headache"
    };
    http:Response result = check hospitalEndpoint->/appointments.post(appointment);
    test:assertEquals(result.statusCode, 201, "Status code should be 201");
}

@test:Config{
  dependsOn: [testCreatePatient, testCreateAppointment]
}
function testCreateAppointmentAlreadyExists() returns error? {
    entities:AppointmentInsert appointment = {
      id: 1,
      patientId: 1,
      doctorId: 1,
      appointmentTime: {year: 2023, month: 7, day: 1, hour: 10, minute: 30},
      status: "SCHEDULED",
      reason: "Headache"
    };
    http:Response result = check hospitalEndpoint->/appointments.post(appointment);
    test:assertEquals(result.statusCode, 409, "Status code should be 409");
}

@test:Config{
  dependsOn: [testCreatePatient]
}
function testGetPatientById() returns error? {
    http:Response result = check hospitalEndpoint->/patients/[1];
    test:assertEquals(result.statusCode, 200, "Status code should be 200");
    test:assertEquals(result.getJsonPayload(), {"id":1, "name": "John Doe", "age": 30, "address": "123, Main Street, Colombo 05", "phoneNumber":"0771690000", "gender":"MALE"}, "Patient details should be returned");
}

@test:Config{}
function testGetPatientNotFound() returns error? {
    http:Response result = check hospitalEndpoint->/patients/[50];
    test:assertEquals(result.statusCode, 404, "Status code should be 404");
}

@test:Config{
  dependsOn: [testCreateAppointment]
}
function testGetAppointmentByDoctor() returns error? {
    http:Response result = check hospitalEndpoint->/doctors/[1]/appointments(year=2023, month=7, day=1);
    test:assertEquals(result.statusCode, 200, "Status code should be 200");
    test:assertEquals(result.getJsonPayload(), [
      {
        "id": 1,
        "doctorId": 1,
        "appointmentTime": {
          "year": 2023,
          "month": 7,
          "day": 1,
          "hour": 10,
          "minute": 30,
          "second": 0
        },
        "status": "SCHEDULED",
        "patient": {
          "id": 1,
          "name": "John Doe",
          "phoneNumber": "0771690000"
        }
      }
    ], "Appointment details should be returned");
    http:Response result2 = check hospitalEndpoint->/doctors/[5]/appointments(year=2023, month=7, day=1);
    test:assertEquals(result2.statusCode, 200, "Status code should be 200");
    test:assertEquals(result2.getJsonPayload(), [], "Appointment details should be empty");
}

@test:Config{
  dependsOn: [testCreateAppointment]
}
function testGetAppointmentByPatient() returns error? {
    http:Response result = check hospitalEndpoint->/patients/[1]/appointments;
    test:assertEquals(result.statusCode, 200, "Status code should be 200");
    test:assertEquals(result.getJsonPayload(), [
      {
        "id": 1,
        "patientId": 1,
        "appointmentTime": {
          "year": 2023,
          "month": 7,
          "day": 1,
          "hour": 10,
          "minute": 30,
          "second": 0
        },
        "status": "SCHEDULED",
        "doctor": {
          "id": 1,
          "name": "Doctor Mouse",
          "specialty": "Physician"
        }
      }
    ], "Appointment details should be returned");
    http:Response result2 = check hospitalEndpoint->/patients/[5]/appointments;
    test:assertEquals(result2.statusCode, 200, "Status code should be 200");
    test:assertEquals(result2.getJsonPayload(), [], "Appointment details should be empty");
}

@test:Config{
  dependsOn: [testCreateAppointment, testGetAppointmentByDoctor, testGetAppointmentByPatient]
}
function testPatchAppointment() returns error? {
    http:Response result = check hospitalEndpoint->/appointments/[1].patch("STARTED");
    test:assertEquals(result.statusCode, 204, "Status code should be 204");
    http:Response result2 = check hospitalEndpoint->/patients/[1]/appointments;
    test:assertEquals(result2.statusCode, 200, "Status code should be 200");
    test:assertEquals(result2.getJsonPayload(), [
      {
        "id": 1,
        "patientId": 1,
        "appointmentTime": {
          "year": 2023,
          "month": 7,
          "day": 1,
          "hour": 10,
          "minute": 30,
          "second": 0
        },
        "status": "STARTED",
        "doctor": {
          "id": 1,
          "name": "Doctor Mouse",
          "specialty": "Physician"
        }
      }
    ], "Appointment details should be returned");
    http:Response result3 = check hospitalEndpoint->/appointments/[10].patch("STARTED");
    test:assertEquals(result3.statusCode, 404, "Status code should be 404");
}

@test:Config{
  dependsOn: [testCreateAppointment, testGetAppointmentByDoctor, testGetAppointmentByPatient, testPatchAppointment]
}
function testDeleteAppointmentByPatientId() returns error? {
    http:Response result = check hospitalEndpoint->/patients/[1]/appointments.delete(year=2023, month=7, day=1);
    test:assertEquals(result.statusCode, 204, "Status code should be 204");
    http:Response result2 = check hospitalEndpoint->/patients/[1]/appointments;
    test:assertEquals(result2.statusCode, 200, "Status code should be 200");
    test:assertEquals(result2.getJsonPayload(), [], "Appointment details should be empty");
}

@test:Config{
  dependsOn: [testGetPatientById, testDeleteAppointmentByPatientId]
}
function testDeletePatient() returns error? {
    http:Response result = check hospitalEndpoint->/patients/[1].delete();
    test:assertEquals(result.statusCode, 204, "Status code should be 204");
}
