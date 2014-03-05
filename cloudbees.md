# Step by Step creation of the environment

```
bees app:create -a petclinic -t tomcat7
bees db:create petclinic

bees app:bind -a petclinic -db petclinic -as petclinic
bees config:set -a petclinic -P spring.profiles.active=default,javaee
bees config:set -a petclinic -P jdbc.initLocation=classpath:db/mysql/initDB.sql
bees config:set -a petclinic -P jdbc.dataLocation=classpath:db/mysql/populateDB.sql
bees config:set -a petclinic -P hibernate.dialect=org.hibernate.dialect.MySQLDialect
bees config:set -a petclinic -P jpa.database=MYSQL
bees config:set -a petclinic -P jpa.showSql=false


bees app:deploy -a petclinic target/petclinic.war
```

# Spring PetClinic Clickstart FAQ

## How does the ClickStart specifies usage of MySQL with a JNDI DataSource

By default, SpringPetClinic uses an embedded HSQL Database defined in `data-access.properties`.

The CloudBees Spring PetClinic Clickstart overides the default parameters defined in `data-access.properties`
to use a JNDI DataSource connected to a MySQL DataSource. This is done setting System Properties with the CloudBees SDK
command `bees config:set -P param=value`. These System Properties are defined in the ClickStart configuration file:
[clickstart.json](https://github.com/CloudBees-community/spring-petclinic-clickstart/blob/master/clickstart.json).

* Use a JNDI DataSource instead of an embedded DataSource activating the Spring Profile `javaee` (see `datasource-config.xml`)

    ```
    bees config:set -a <MYAPP> -P spring.profiles.active=default,javaee
    ```

* Specify the MySQL dialect

    ```
    config:set -a petclinic -P jdbc.initLocation=classpath:db/mysql/initDB.sql
    config:set -a petclinic -P jdbc.dataLocation=classpath:db/mysql/populateDB.sql
    config:set -a petclinic -P hibernate.dialect=org.hibernate.dialect.MySQLDialect
    config:set -a petclinic -P jpa.database=MYSQL
    ```
    
Note: it is possible to override `data-access.properties` values with System Properties because the `<context:property-placeholder />` is defined with `system-properties-mode="OVERRIDE"`:

```xml
<context:property-placeholder 
   location="classpath:spring/data-access.properties" 
   system-properties-mode="OVERRIDE"/>
```
