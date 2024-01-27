# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.2.2/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/3.2.2/maven-plugin/reference/html/#build-image)

### WebClient : 
https://www.baeldung.com/webflux-webclient-parameters

### Spring resilience4J
https://docs.spring.io/spring-cloud-circuitbreaker/docs/current/reference/html/spring-cloud-circuitbreaker-resilience4j.html
https://medium.com/@truongbui95/circuit-breaker-pattern-in-spring-boot-d2d258b75042

### !! FIX -error Java-time :
https://stackoverflow.com/questions/70412805/what-does-this-error-mean-java-lang-reflect-inaccessibleobjectexception-unable
Description:
    Failed to bind properties under 'resilience4j.circuitbreaker.instances.services-loan.wait-duration-in-open-state' to java.time.Duration:
    Reason: java.lang.reflect.InaccessibleObjectException: Unable to make private java.time.Duration(long,int) accessible: module java.base does not "opens java.time" to unnamed module @e4487af

add default VM arguments, Edit configurations, -> add VM argument
--add-opens java.base/java.time=ALL-UNNAMED