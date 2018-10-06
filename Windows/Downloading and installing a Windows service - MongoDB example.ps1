mkdir C:\Mongo\data\db
mkdir C:\Mongo\data\log
 
"" > C:\Mongo\data\log\mongod.log
 
# The minimum needed for a MongoDB config file
 
@"
systemLog:
    destination: file
    path: C:\Mongo\data\log\mongod.log
storage:
    dbPath: C:\Mongo\data\db
"@	> "C:\Mongo\mongod.cfg"
 
 
# This is version 3.2, thus the 3.2 in the path for the binary in the new-service call
Invoke-WebRequest http://downloads.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-v3.2-latest-signed.msi?_ga=1.56414827.19723263.1478030430 -OutFile mongodb.msi 
 
# /qn runs the install silently (with all defaults unless you specify otherwise)
start-process mongodb.msi /qn -Wait
 
new-service -Name "MongoDB" -binaryPathName '"C:\Program Files\MongoDB\Server\3.2\bin\mongod.exe" --service --config "C:\Mongo\mongod.cfg"' -DisplayName "MongoDB" -StartupType Automatic
 
Start-Service -DisplayName "MongoDB"