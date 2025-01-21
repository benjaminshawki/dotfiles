<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.7.2</version>
		<relativePath/>
	</parent>
	<groupId>nl.duckstudios</groupId>
	<artifactId>pintandpillage</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>pintandpillage</name>
	<description>Demo project for Spring Boot</description>
	<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
		<java.version>17</java.version>
	</properties>
	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>org.postgresql</groupId>
			<artifactId>postgresql</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-security</artifactId>
		</dependency>
		<dependency>
			<groupId>com.auth0</groupId>
			<artifactId>java-jwt</artifactId>
			<version>4.0.0</version>
		</dependency>
		<dependency>
			<groupId>org.passay</groupId>
			<artifactId>passay</artifactId>
			<version>1.6.1</version>
		</dependency>
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>1.18.24</version>
			<scope>provided</scope>
		</dependency>
	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version> <!-- Verify if there's a newer version compatible with Java 17 features -->
            <configuration>
                <release>17</release> <!-- This is crucial for Java 9 and above to ensure correct module handling -->
                <encoding>UTF-8</encoding>
            </configuration>
        </plugin>
<plugin>
    <groupId>com.diffplug.spotless</groupId>
    <artifactId>spotless-maven-plugin</artifactId>
    <version>2.43.0</version>
    <configuration>
        <java>
            <googleJavaFormat/>
        </java>
    </configuration>
</plugin>

        </plugins>
	</build>

</project>


<?xml version="1.0"?>
<!DOCTYPE module PUBLIC "-//Checkstyle//DTD Checkstyle Configuration 1.3//EN"
"https://checkstyle.org/dtds/configuration_1_3.dtd">
<module name="Checker">

  <!-- Correct placement of RegexpSingleline -->
  <module name="RegexpSingleline">
    <property name="format" value="\s+$"/>
    <property name="message" value="Trailing spaces are not allowed."/>
  </module>

  <module name="TreeWalker">
    <!-- Properties -->
    <property name="fileExtensions" value="java"/>

    <!-- Indentation checks -->
    <module name="Indentation">
      <property name="basicOffset" value="2"/>
      <property name="braceAdjustment" value="0"/>
      <property name="caseIndent" value="2"/>
      <property name="throwsIndent" value="2"/>
      <property name="lineWrappingIndentation" value="4"/>
      <property name="arrayInitIndent" value="2"/>
    </module>

    <!-- File Encoding, correctly placed within TreeWalker -->
    <module name="FileEncoding">
      <property name="charset" value="UTF-8"/>
    </module>
  </module>

  <!-- Line Length -->
  <!-- <module name="LineLength"> -->
  <!--   <property name="max" value="100"/> -->
  <!-- </module> -->

  <!-- Newline at end of file -->
  <module name="NewlineAtEndOfFile">
    <property name="fileExtensions" value="java, svg"/>
  </module>
</module>
:q

~/dev/pintandpillage-containerized/PintAndPillageJavaBackend > mvn checkstyle:check                                                                        λ:main  [   ]
[INFO] Scanning for projects...
[INFO]
[INFO] -------------------< nl.duckstudios:pintandpillage >--------------------
[INFO] Building pintandpillage 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:3.3.1:check (default-cli) @ pintandpillage ---
[INFO] There are 1725 errors reported by Checkstyle 9.3 with sun_checks.xml ruleset.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageRepository.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageRepository.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelRepository.java:[9,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[11,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[11,22] (misc) FinalParameters: Parameter buildingRepository should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[11,41] (coding) HiddenField: 'buildingRepository' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[15,3] (design) DesignForExtension: Class 'BuildingDAO' looks like designed for extension (can be subclassed), but the method 'getBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BuildingDAO' final or making the method 'getBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[15,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingDAO.java:[15,31] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[11,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[11,20] (misc) FinalParameters: Parameter travelRepository should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[11,37] (coding) HiddenField: 'travelRepository' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[15,3] (design) DesignForExtension: Class 'TravelDao' looks like designed for extension (can be subclassed), but the method 'insertAttack' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'TravelDao' final or making the method 'insertAttack' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[15,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/TravelDao.java:[15,28] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[13,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[13,21] (misc) FinalParameters: Parameter villageRepository should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[13,39] (coding) HiddenField: 'villageRepository' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[17,3] (design) DesignForExtension: Class 'VillageDAO' looks like designed for extension (can be subclassed), but the method 'save' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDAO' final or making the method 'save' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[17,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[17,23] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[21,3] (design) DesignForExtension: Class 'VillageDAO' looks like designed for extension (can be subclassed), but the method 'getVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDAO' final or making the method 'getVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[21,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[21,29] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[22] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[25,3] (design) DesignForExtension: Class 'VillageDAO' looks like designed for extension (can be subclassed), but the method 'getVillages' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDAO' final or making the method 'getVillages' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[25,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[25,36] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[29,3] (design) DesignForExtension: Class 'VillageDAO' looks like designed for extension (can be subclassed), but the method 'getVillages' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDAO' final or making the method 'getVillages' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDAO.java:[29,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserRepository.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/BuildingRepository.java:[9,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[16,28] (misc) FinalParameters: Parameter villageDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[16,39] (coding) HiddenField: 'villageDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[20,3] (design) DesignForExtension: Class 'VillageDataMapper' looks like designed for extension (can be subclassed), but the method 'getVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDataMapper' final or making the method 'getVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[20,29] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[27,3] (design) DesignForExtension: Class 'VillageDataMapper' looks like designed for extension (can be subclassed), but the method 'getVillages' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDataMapper' final or making the method 'getVillages' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[27,36] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[31,3] (design) DesignForExtension: Class 'VillageDataMapper' looks like designed for extension (can be subclassed), but the method 'createBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDataMapper' final or making the method 'createBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[31,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[31,33] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[31,50] (misc) FinalParameters: Parameter building should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[39,3] (design) DesignForExtension: Class 'VillageDataMapper' looks like designed for extension (can be subclassed), but the method 'update' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDataMapper' final or making the method 'update' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[39,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[39,22] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[43,3] (design) DesignForExtension: Class 'VillageDataMapper' looks like designed for extension (can be subclassed), but the method 'getWorldVillages' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageDataMapper' final or making the method 'getWorldVillages' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/VillageDataMapper.java:[43,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[12,18] (misc) FinalParameters: Parameter userRepository should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[12,33] (coding) HiddenField: 'userRepository' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[16,3] (design) DesignForExtension: Class 'UserDAO' looks like designed for extension (can be subclassed), but the method 'findByEmail' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UserDAO' final or making the method 'findByEmail' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[16,37] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[20,3] (design) DesignForExtension: Class 'UserDAO' looks like designed for extension (can be subclassed), but the method 'save' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UserDAO' final or making the method 'save' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[20,20] (misc) FinalParameters: Parameter user should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[24,3] (design) DesignForExtension: Class 'UserDAO' looks like designed for extension (can be subclassed), but the method 'findUsernameById' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UserDAO' final or making the method 'findUsernameById' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[24,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/dao/UserDAO.java:[24,42] (misc) FinalParameters: Parameter userId should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/PintAndPillageApplication.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/PintAndPillageApplication.java:[6,1] (design) HideUtilityClassConstructor: Utility classes should not have a public or default constructor.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/PintAndPillageApplication.java:[9,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/PintAndPillageApplication.java:[9,27] (misc) FinalParameters: Parameter args should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[13,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[27,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[27,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[28,7] (misc) FinalParameters: Parameter buildingService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[28,23] (coding) HiddenField: 'buildingService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[29,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[29,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[30,7] (misc) FinalParameters: Parameter accountService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[30,22] (coding) HiddenField: 'accountService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[31,7] (misc) FinalParameters: Parameter unitFactory should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[31,19] (coding) HiddenField: 'unitFactory' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[39,3] (design) DesignForExtension: Class 'ProductionController' looks like designed for extension (can be subclassed), but the method 'trainUnitsInBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ProductionController' final or making the method 'trainUnitsInBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[39,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[41] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[41,39] (misc) FinalParameters: Parameter unitCreateData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ProductionController.java:[44] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[12,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[25,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[26,7] (misc) FinalParameters: Parameter worldService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[26,20] (coding) HiddenField: 'worldService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[27,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[27,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[28,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[28,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[29,7] (misc) FinalParameters: Parameter highscoreService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[29,24] (coding) HiddenField: 'highscoreService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[36,3] (design) DesignForExtension: Class 'WorldController' looks like designed for extension (can be subclassed), but the method 'getWorld' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldController' final or making the method 'getWorld' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[36,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[42,3] (design) DesignForExtension: Class 'WorldController' looks like designed for extension (can be subclassed), but the method 'getSettleableSpots' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldController' final or making the method 'getSettleableSpots' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[42,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[44,45] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[50,3] (design) DesignForExtension: Class 'WorldController' looks like designed for extension (can be subclassed), but the method 'getHighscore' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldController' final or making the method 'getHighscore' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/WorldController.java:[50,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[12,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[24,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[25,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[25,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[26,7] (misc) FinalParameters: Parameter buildingService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[26,23] (coding) HiddenField: 'buildingService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[27,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[27,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[28,7] (misc) FinalParameters: Parameter accountService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[28,22] (coding) HiddenField: 'accountService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[29,7] (misc) FinalParameters: Parameter buildingFactory should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[29,23] (coding) HiddenField: 'buildingFactory' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[37,3] (design) DesignForExtension: Class 'BuildingController' looks like designed for extension (can be subclassed), but the method 'createBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BuildingController' final or making the method 'createBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[37,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[39] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[39,33] (misc) FinalParameters: Parameter buildingCreateData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[41] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[45] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[50,3] (design) DesignForExtension: Class 'BuildingController' looks like designed for extension (can be subclassed), but the method 'levelUpBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BuildingController' final or making the method 'levelUpBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[50,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/BuildingController.java:[52,34] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[14,45] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.service.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[15,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[26,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[29,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[30,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[30,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[31,7] (misc) FinalParameters: Parameter accountService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[31,22] (coding) HiddenField: 'accountService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[32,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[32,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[33,7] (misc) FinalParameters: Parameter combatService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[33,21] (coding) HiddenField: 'combatService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[34,7] (misc) FinalParameters: Parameter travelDao should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[34,17] (coding) HiddenField: 'travelDao' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[35,7] (misc) FinalParameters: Parameter distanceService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[35,23] (coding) HiddenField: 'distanceService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[44,3] (design) DesignForExtension: Class 'CombatController' looks like designed for extension (can be subclassed), but the method 'attackVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'CombatController' final or making the method 'attackVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[44,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[46,32] (misc) FinalParameters: Parameter data should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[48] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[53] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[58] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[60] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[64] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[72,30] (naming) MethodName: Name 'CreateCombatTravel' must match pattern '^[a-z][a-zA-Z0-9]*$'.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[73] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[73,7] (misc) FinalParameters: Parameter attackingUnits should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[73,41] (misc) FinalParameters: Parameter attackingVillage should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[73,67] (misc) FinalParameters: Parameter defendingVillage should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[75] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[78] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[79] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[81] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/CombatController.java:[81,64] (coding) MagicNumber: '1000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[18,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[26,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[30,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[32,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[33,7] (misc) FinalParameters: Parameter villageFactory should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[33,22] (coding) HiddenField: 'villageFactory' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[34,7] (misc) FinalParameters: Parameter villageDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[34,18] (coding) HiddenField: 'villageDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[35,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[35,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[36,7] (misc) FinalParameters: Parameter accountService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[36,22] (coding) HiddenField: 'accountService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[37,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[37,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[38,7] (misc) FinalParameters: Parameter worldService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[38,20] (coding) HiddenField: 'worldService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[47,3] (design) DesignForExtension: Class 'VillageController' looks like designed for extension (can be subclassed), but the method 'createVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageController' final or making the method 'createVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[47,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[57,3] (design) DesignForExtension: Class 'VillageController' looks like designed for extension (can be subclassed), but the method 'getVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageController' final or making the method 'getVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[57,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[59,29] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[68,3] (design) DesignForExtension: Class 'VillageController' looks like designed for extension (can be subclassed), but the method 'getVillagesFromUser' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageController' final or making the method 'getVillagesFromUser' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[68,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[72] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[82,3] (design) DesignForExtension: Class 'VillageController' looks like designed for extension (can be subclassed), but the method 'changeVillageName' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageController' final or making the method 'changeVillageName' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[82,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[85] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[85,7] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[85,30] (misc) FinalParameters: Parameter villageNameChangeData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[97,3] (design) DesignForExtension: Class 'VillageController' looks like designed for extension (can be subclassed), but the method 'startNewVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageController' final or making the method 'startNewVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[97,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[99,34] (misc) FinalParameters: Parameter newVillageData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[105] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[107] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[111] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/VillageController.java:[116] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[13,47] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.springframework.web.bind.annotation.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[27,7] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[27,22] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[28,7] (misc) FinalParameters: Parameter buildingService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[28,23] (coding) HiddenField: 'buildingService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[29,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[29,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[30,7] (misc) FinalParameters: Parameter accountService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[30,22] (coding) HiddenField: 'accountService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[31,7] (misc) FinalParameters: Parameter researchFactory should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[31,23] (coding) HiddenField: 'researchFactory' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[39,3] (design) DesignForExtension: Class 'ResearchController' looks like designed for extension (can be subclassed), but the method 'startResearch' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResearchController' final or making the method 'startResearch' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[39,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[41] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[41,32] (misc) FinalParameters: Parameter researchStartData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[44] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[58] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[58,36] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[58,53] (misc) FinalParameters: Parameter researchStartData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[61] (sizes) LineLength: Line is longer than 80 characters (found 91).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/ResearchController.java:[63] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[18,18] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - org.passay.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[32,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[33,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[34,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[35,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[37,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[38,7] (misc) FinalParameters: Parameter jwtUtil should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[38,20] (coding) HiddenField: 'jwtUtil' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[39,7] (misc) FinalParameters: Parameter authManager should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[39,29] (coding) HiddenField: 'authManager' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[40,7] (misc) FinalParameters: Parameter passwordEncoder should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[40,23] (coding) HiddenField: 'passwordEncoder' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[41,7] (misc) FinalParameters: Parameter userDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[41,15] (coding) HiddenField: 'userDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[48,3] (design) DesignForExtension: Class 'AuthController' looks like designed for extension (can be subclassed), but the method 'register' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'AuthController' final or making the method 'register' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[48,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[49,39] (misc) FinalParameters: Parameter user should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[71,3] (design) DesignForExtension: Class 'AuthController' looks like designed for extension (can be subclassed), but the method 'login' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'AuthController' final or making the method 'login' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[71,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[72,26] (misc) FinalParameters: Parameter body should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[97,35] (misc) FinalParameters: Parameter password should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[101,32] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[101,35] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[112,32] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[113,19] (naming) LocalFinalVariableName: Name 'VALID_EMAIL_ADDRESS_REGEX' must match pattern '^[a-z][a-zA-Z0-9]*$'.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/controller/AuthController.java:[114] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17,23] (misc) FinalParameters: Parameter villageDataMapper should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17,41] (coding) HiddenField: 'villageDataMapper' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17,60] (misc) FinalParameters: Parameter distanceService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[17,76] (coding) HiddenField: 'distanceService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[22,3] (design) DesignForExtension: Class 'WorldService' looks like designed for extension (can be subclassed), but the method 'getWorldMap' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldService' final or making the method 'getWorldMap' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[22,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[23,38] (coding) MagicNumber: '34843' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[23,45] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[23,49] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[23,53] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[29,3] (design) DesignForExtension: Class 'WorldService' looks like designed for extension (can be subclassed), but the method 'getSettleableSpots' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldService' final or making the method 'getSettleableSpots' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[29,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[29,45] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[29,54] (misc) FinalParameters: Parameter user should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[35] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[40] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[41] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/WorldService.java:[44] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AccountService.java:[10,3] (design) DesignForExtension: Class 'AccountService' looks like designed for extension (can be subclassed), but the method 'checkIsCorrectUser' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'AccountService' final or making the method 'checkIsCorrectUser' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AccountService.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AccountService.java:[10,34] (misc) FinalParameters: Parameter userId should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AccountService.java:[10,47] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[12,26] (misc) FinalParameters: Parameter buildingDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[12,38] (coding) HiddenField: 'buildingDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[16,3] (design) DesignForExtension: Class 'BuildingService' looks like designed for extension (can be subclassed), but the method 'getBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BuildingService' final or making the method 'getBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/BuildingService.java:[16,31] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[18,27] (misc) FinalParameters: Parameter userDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[18,35] (coding) HiddenField: 'userDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[18,44] (misc) FinalParameters: Parameter villageService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[18,59] (coding) HiddenField: 'villageService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[23,3] (design) DesignForExtension: Class 'HighscoreService' looks like designed for extension (can be subclassed), but the method 'getHighscore' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'HighscoreService' final or making the method 'getHighscore' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[23,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/HighscoreService.java:[29] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[18,22] (misc) FinalParameters: Parameter userDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[18,30] (coding) HiddenField: 'userDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[22,3] (design) DesignForExtension: Class 'UserService' looks like designed for extension (can be subclassed), but the method 'loadUserByUsername' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UserService' final or making the method 'loadUserByUsername' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/UserService.java:[23,41] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[18,3] (design) DesignForExtension: Class 'CombatService' looks like designed for extension (can be subclassed), but the method 'convertToVillageUnits' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'CombatService' final or making the method 'convertToVillageUnits' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[18,50] (misc) FinalParameters: Parameter data should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[34] (sizes) LineLength: Line is longer than 80 characters (found 96).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[39] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[45,3] (design) DesignForExtension: Class 'CombatService' looks like designed for extension (can be subclassed), but the method 'checkHasEnoughUnitsToAttack' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'CombatService' final or making the method 'checkHasEnoughUnitsToAttack' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[45,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[46,7] (misc) FinalParameters: Parameter attackingUnits should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[46,41] (misc) FinalParameters: Parameter attackingVillage should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[49] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[54] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[63,3] (design) DesignForExtension: Class 'CombatService' looks like designed for extension (can be subclassed), but the method 'checkHasEnoughShipsToSendUnits' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'CombatService' final or making the method 'checkHasEnoughShipsToSendUnits' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[63,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[63,46] (misc) FinalParameters: Parameter villageUnits should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[67] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[72] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[73] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/CombatService.java:[77] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[6,17] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - java.util.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[26,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[29,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[31,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[32,7] (misc) FinalParameters: Parameter villageDataMapper should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[32,25] (coding) HiddenField: 'villageDataMapper' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[33,7] (misc) FinalParameters: Parameter resourceManager should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[33,23] (coding) HiddenField: 'resourceManager' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[34,7] (misc) FinalParameters: Parameter worldService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[34,20] (coding) HiddenField: 'worldService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[35,7] (misc) FinalParameters: Parameter distanceService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[35,23] (coding) HiddenField: 'distanceService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[42,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'getVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'getVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[42,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[42,29] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[48,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'getListOfVillagesFromUser' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'getListOfVillagesFromUser' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[48,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[48,50] (misc) FinalParameters: Parameter id should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[52,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'createBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'createBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[52,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[52,33] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[52,50] (misc) FinalParameters: Parameter building should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[56,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'update' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'update' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[56,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[56,22] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[60,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'getWorldVillages' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'getWorldVillages' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[60,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[64,3] (design) DesignForExtension: Class 'VillageService' looks like designed for extension (can be subclassed), but the method 'checkIsValidCreatingSpot' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageService' final or making the method 'checkIsValidCreatingSpot' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[64,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[64,40] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[64,57] (misc) FinalParameters: Parameter newPosition should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[66] (sizes) LineLength: Line is longer than 80 characters (found 91).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[76] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[80,41] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[80,58] (misc) FinalParameters: Parameter newPosition should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[87] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[91,34] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[102] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[103] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[115,22] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[128,23] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[137,35] (coding) MagicNumber: '0.1f' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[140] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[156] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[160,27] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[160,54] (misc) FinalParameters: Parameter percentLost should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[162] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[163] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[169] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[172,26] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[172,53] (misc) FinalParameters: Parameter percentLost should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[175] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[180] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[183] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[188] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[192] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[194] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[203] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[208] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[211,52] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[215] (sizes) LineLength: Line is longer than 80 characters (found 96).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[222] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[226,28] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[226,45] (misc) FinalParameters: Parameter travel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[231] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/VillageService.java:[232] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[13,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[13,32] (misc) FinalParameters: Parameter userDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[13,40] (coding) HiddenField: 'userDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[17,3] (design) DesignForExtension: Class 'AuthenticationService' looks like designed for extension (can be subclassed), but the method 'getAuthenticatedUser' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'AuthenticationService' final or making the method 'getAuthenticatedUser' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[17,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/AuthenticationService.java:[18] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/DistanceService.java:[9,3] (design) DesignForExtension: Class 'DistanceService' looks like designed for extension (can be subclassed), but the method 'calculateDistance' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'DistanceService' final or making the method 'calculateDistance' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/DistanceService.java:[9,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/DistanceService.java:[9,32] (misc) FinalParameters: Parameter coordA should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/DistanceService.java:[9,46] (misc) FinalParameters: Parameter coordB should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/service/DistanceService.java:[14] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[30,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[32,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[34,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[36,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[37,7] (misc) FinalParameters: Parameter userDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[37,15] (coding) HiddenField: 'userDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[38,7] (misc) FinalParameters: Parameter villageFactory should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[38,22] (coding) HiddenField: 'villageFactory' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[39,7] (misc) FinalParameters: Parameter villageDataMapper should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[39,25] (coding) HiddenField: 'villageDataMapper' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[40,7] (misc) FinalParameters: Parameter villageDAO should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[40,18] (coding) HiddenField: 'villageDAO' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[41,7] (misc) FinalParameters: Parameter authenticationService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[41,29] (coding) HiddenField: 'authenticationService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[49,3] (design) DesignForExtension: Class 'Seeder' looks like designed for extension (can be subclassed), but the method 'seed' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Seeder' final or making the method 'seed' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[49,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[50,20] (misc) FinalParameters: Parameter event should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[55,3] (design) DesignForExtension: Class 'Seeder' looks like designed for extension (can be subclassed), but the method 'seedUser' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Seeder' final or making the method 'seedUser' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[55,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[69,3] (design) DesignForExtension: Class 'Seeder' looks like designed for extension (can be subclassed), but the method 'seedVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Seeder' final or making the method 'seedVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[69,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[74] (sizes) LineLength: Line is longer than 80 characters (found 96).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[74,88] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[74,92] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[76,25] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[82,22] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[84,35] (coding) MagicNumber: '9' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[84,38] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[88,23] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[90,36] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[90,40] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[94,22] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[96,38] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[101,46] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[102,45] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[103,45] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[104,44] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[116,35] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[123] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[123,86] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[123,90] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[125,25] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[131,22] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[133,35] (coding) MagicNumber: '9' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[133,38] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[137,23] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[139,36] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[139,40] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[143,22] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[145,38] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[150,46] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[151,45] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[152,45] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[153,44] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Seeder.java:[165,34] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[5,19] (design) VisibilityModifier: Variable 'unitType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[6,14] (design) VisibilityModifier: Variable 'amount' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[8,25] (misc) FinalParameters: Parameter unitType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[8,34] (coding) HiddenField: 'unitType' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[8,44] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackUnitData.java:[8,48] (coding) HiddenField: 'amount' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/TileType.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/TileType.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LogTypes.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LogTypes.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LogTypes.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/JwtResult.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/JwtResult.java:[4,17] (design) VisibilityModifier: Variable 'token' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/JwtResult.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/JwtResult.java:[6,18] (design) VisibilityModifier: Variable 'isFirstTimeLoggedIn' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchStartData.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchStartData.java:[5,15] (design) VisibilityModifier: Variable 'researchBuildingId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchStartData.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchStartData.java:[7,17] (design) VisibilityModifier: Variable 'researchType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[7,17] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[9,16] (design) VisibilityModifier: Variable 'position' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[11,17] (design) VisibilityModifier: Variable 'allowedBuilding' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[13,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[13,24] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[13,31] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[13,38] (misc) FinalParameters: Parameter allowedBuilding should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[13,45] (coding) HiddenField: 'allowedBuilding' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[18,24] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildPosition.java:[18,31] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/NewVillageData.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/NewVillageData.java:[7,15] (design) VisibilityModifier: Variable 'villageId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/NewVillageData.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/NewVillageData.java:[8,16] (design) VisibilityModifier: Variable 'newPosition' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResearchType.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[6,15] (design) VisibilityModifier: Variable 'villageId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[8,17] (design) VisibilityModifier: Variable 'villageOwnerName' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[10,16] (design) VisibilityModifier: Variable 'position' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[12,17] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[14,14] (design) VisibilityModifier: Variable 'points' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[16,15] (design) VisibilityModifier: Variable 'userId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[19,7] (misc) FinalParameters: Parameter villageId should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[19,12] (coding) HiddenField: 'villageId' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[20,7] (misc) FinalParameters: Parameter villageOwnerName should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[20,14] (coding) HiddenField: 'villageOwnerName' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[21,7] (misc) FinalParameters: Parameter position should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[21,13] (coding) HiddenField: 'position' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[22,7] (misc) FinalParameters: Parameter name should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[22,14] (coding) HiddenField: 'name' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[23,7] (misc) FinalParameters: Parameter userId should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[23,12] (coding) HiddenField: 'userId' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[24,7] (misc) FinalParameters: Parameter points should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/WorldVillage.java:[24,11] (coding) HiddenField: 'points' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitType.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResourceType.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResourceType.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResourceType.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/ResourceType.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[4,17] (design) VisibilityModifier: Variable 'username' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[5,14] (design) VisibilityModifier: Variable 'totalPoints' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[7,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[7,24] (misc) FinalParameters: Parameter username should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[7,31] (coding) HiddenField: 'username' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[7,41] (misc) FinalParameters: Parameter totalPoints should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UserHighscore.java:[7,45] (coding) HiddenField: 'totalPoints' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[4,19] (design) VisibilityModifier: Variable 'tileType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[5,14] (design) VisibilityModifier: Variable 'x' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[6,14] (design) VisibilityModifier: Variable 'y' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,15] (misc) FinalParameters: Parameter tileType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,24] (coding) HiddenField: 'tileType' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,34] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,38] (coding) HiddenField: 'x' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,41] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Tile.java:[8,45] (coding) HiddenField: 'y' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[11,14] (design) VisibilityModifier: Variable 'villageId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[13,17] (design) VisibilityModifier: Variable 'buildingType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/BuildingCreateData.java:[16,16] (design) VisibilityModifier: Variable 'coord' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[5,17] (design) VisibilityModifier: Variable 'username' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[6,17] (design) VisibilityModifier: Variable 'password' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[8,29] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[8,30] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[10,27] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[10,41] (misc) FinalParameters: Parameter password should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/LoginCredentials.java:[10,48] (coding) HiddenField: 'password' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[6,15] (design) VisibilityModifier: Variable 'unit' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[8,14] (design) VisibilityModifier: Variable 'levelUnlocked' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[10,31] (misc) FinalParameters: Parameter unit should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[10,36] (coding) HiddenField: 'unit' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[10,42] (misc) FinalParameters: Parameter levelUnlocked should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitsProductListData.java:[10,46] (coding) HiddenField: 'levelUnlocked' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[5,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[5,15] (design) VisibilityModifier: Variable 'productionBuildingId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[7,17] (design) VisibilityModifier: Variable 'unitType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/UnitCreateData.java:[9,14] (design) VisibilityModifier: Variable 'amount' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/SettleableSpots.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/SettleableSpots.java:[9,14] (design) VisibilityModifier: Variable 'amountOfJarlsNeeded' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/SettleableSpots.java:[10,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/SettleableSpots.java:[10,22] (design) VisibilityModifier: Variable 'validPositions' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/SettleableSpots.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[4,19] (design) VisibilityModifier: Variable 'unitType' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[6,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[6,14] (design) VisibilityModifier: Variable 'level' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[8,17] (misc) FinalParameters: Parameter unitType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[8,26] (coding) HiddenField: 'unitType' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[8,36] (misc) FinalParameters: Parameter level should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/Unlock.java:[8,40] (coding) HiddenField: 'level' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[7,31] (design) VisibilityModifier: Variable 'units' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[8,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[8,15] (design) VisibilityModifier: Variable 'fromVillageId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/AttackVillageData.java:[9,15] (design) VisibilityModifier: Variable 'toVillageId' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/VillageNameChangeData.java:[4,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/model/VillageNameChangeData.java:[4,17] (design) VisibilityModifier: Variable 'newName' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/NoEmptyVillageSpotFoundException.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/NoEmptyVillageSpotFoundException.java:[4,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/NoEmptyVillageSpotFoundException.java:[4,43] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/AttackingConditionsNotMetException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/AttackingConditionsNotMetException.java:[8,45] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UserAlreadyExistsException.java:[5,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UserAlreadyExistsException.java:[5,37] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/BuildingConditionsNotMetException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/BuildingConditionsNotMetException.java:[8,44] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/NotExistingEntityException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/NotExistingEntityException.java:[8,37] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/SettleConditionsNotMetException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/SettleConditionsNotMetException.java:[8,42] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UnauthorizedException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UnauthorizedException.java:[8,32] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UnmetEmailRequirementsException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ResearchConditionsNotMetException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ResearchConditionsNotMetException.java:[8,44] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/UnmetPasswordRequirementsException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ProductionConditionsNotMetException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ProductionConditionsNotMetException.java:[8,46] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ForbiddenException.java:[8,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/Exceptions/ForbiddenException.java:[8,29] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[22,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[22,20] (misc) FinalParameters: Parameter userService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[22,32] (coding) HiddenField: 'userService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[22,45] (misc) FinalParameters: Parameter jwtTokenUtil should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[22,58] (coding) HiddenField: 'jwtTokenUtil' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[27,3] (design) DesignForExtension: Class 'JWTFilter' looks like designed for extension (can be subclassed), but the method 'doFilterInternal' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'JWTFilter' final or making the method 'doFilterInternal' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[29] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[29,7] (misc) FinalParameters: Parameter request should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[29,35] (misc) FinalParameters: Parameter response should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[29,65] (misc) FinalParameters: Parameter filterChain should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[33,41] (coding) MagicNumber: '7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[36] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[44] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JWTFilter.java:[49,30] (coding) MagicNumber: '401' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[23,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[23,25] (misc) FinalParameters: Parameter filter should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[23,35] (coding) HiddenField: 'filter' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[23,43] (misc) FinalParameters: Parameter userService should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[23,55] (coding) HiddenField: 'userService' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[28,3] (design) DesignForExtension: Class 'SecurityConfig' looks like designed for extension (can be subclassed), but the method 'filterChain' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'SecurityConfig' final or making the method 'filterChain' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[28,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[29,42] (misc) FinalParameters: Parameter http should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[55] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[60] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[63,3] (design) DesignForExtension: Class 'SecurityConfig' looks like designed for extension (can be subclassed), but the method 'passwordEncoder' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'SecurityConfig' final or making the method 'passwordEncoder' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[63,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[68,3] (design) DesignForExtension: Class 'SecurityConfig' looks like designed for extension (can be subclassed), but the method 'authenticationManager' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'SecurityConfig' final or making the method 'authenticationManager' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[68,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[70] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/SecurityConfig.java:[70,7] (misc) FinalParameters: Parameter authenticationConfiguration should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[20] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[20,3] (design) DesignForExtension: Class 'JwtTokenUtil' looks like designed for extension (can be subclassed), but the method 'generateToken' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'JwtTokenUtil' final or making the method 'generateToken' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[20,31] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[31] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[31,3] (design) DesignForExtension: Class 'JwtTokenUtil' looks like designed for extension (can be subclassed), but the method 'validateTokenAndRetrieveSubject' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'JwtTokenUtil' final or making the method 'validateTokenAndRetrieveSubject' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[31,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[31,49] (misc) FinalParameters: Parameter token should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/config/JwtTokenUtil.java:[42,27] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[5,54] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.entity.buildings.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[11,3] (design) DesignForExtension: Class 'BuildingFactory' looks like designed for extension (can be subclassed), but the method 'getBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BuildingFactory' final or making the method 'getBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[11,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[11,31] (misc) FinalParameters: Parameter buildingName should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[11,52] (misc) FinalParameters: Parameter position should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/BuildingFactory.java:[73] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[4,55] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.entity.production.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[10,36] (misc) FinalParameters: Parameter unitType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[14,3] (design) DesignForExtension: Class 'UnitFactory' looks like designed for extension (can be subclassed), but the method 'getUnit' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UnitFactory' final or making the method 'getUnit' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[14,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[14,23] (misc) FinalParameters: Parameter unitType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/UnitFactory.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[10,3] (design) DesignForExtension: Class 'ResourceManager' looks like designed for extension (can be subclassed), but the method 'hasEnoughResourcesAvailable' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceManager' final or making the method 'hasEnoughResourcesAvailable' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[11,7] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[11,24] (misc) FinalParameters: Parameter resourcesRequiredLevelUp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[13] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[15] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[15,7] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[21,3] (design) DesignForExtension: Class 'ResourceManager' looks like designed for extension (can be subclassed), but the method 'hasEnoughResourcesAvailable' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceManager' final or making the method 'hasEnoughResourcesAvailable' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[21,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[22] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[22,7] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[22,24] (misc) FinalParameters: Parameter resourcesRequiredLevelUp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[22,71] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[26] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[26,7] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[32,3] (design) DesignForExtension: Class 'ResourceManager' looks like designed for extension (can be subclassed), but the method 'subtractResources' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceManager' final or making the method 'subtractResources' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[32,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[32,33] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[32,50] (misc) FinalParameters: Parameter resourcesRequiredLevelUp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[34] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[38] (sizes) LineLength: Line is longer than 80 characters (found 91).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[43,3] (design) DesignForExtension: Class 'ResourceManager' looks like designed for extension (can be subclassed), but the method 'addResources' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceManager' final or making the method 'addResources' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[43,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[43,28] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[43,45] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[43,57] (misc) FinalParameters: Parameter type should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResourceManager.java:[45] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResearchFactory.java:[4,56] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.entity.researching.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResearchFactory.java:[10,3] (design) DesignForExtension: Class 'ResearchFactory' looks like designed for extension (can be subclassed), but the method 'getResearch' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResearchFactory' final or making the method 'getResearch' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResearchFactory.java:[10,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResearchFactory.java:[10,31] (misc) FinalParameters: Parameter researchType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/ResearchFactory.java:[18] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[12,3] (design) DesignForExtension: Class 'VillageFactory' looks like designed for extension (can be subclassed), but the method 'createBasicVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'VillageFactory' final or making the method 'createBasicVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[12,37] (misc) FinalParameters: Parameter user should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[12,48] (misc) FinalParameters: Parameter coord should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[21,30] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[21,33] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/helper/VillageFactory.java:[33] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[11] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[13,3] (design) DesignForExtension: Class 'Resources' looks like designed for extension (can be subclassed), but the method 'addResource' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Resources' final or making the method 'addResource' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[13,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[13,27] (misc) FinalParameters: Parameter resource should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Resources.java:[13,50] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[20,16] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[20,20] (coding) HiddenField: 'x' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[20,23] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[20,27] (coding) HiddenField: 'y' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[25,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[25,18] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Coord.java:[25,19] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/ShipUnit.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/ShipUnit.java:[5,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[15] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[19,41] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[20,40] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[21,39] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[22,47] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[23,38] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[25,59] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[35,43] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[36,44] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[37,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/DefenceShip.java:[42,3] (design) DesignForExtension: Class 'DefenceShip' looks like designed for extension (can be subclassed), but the method 'getShipCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'DefenceShip' final or making the method 'getShipCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[7,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[16,27] (design) VisibilityModifier: Variable 'unitName' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[17,22] (design) VisibilityModifier: Variable 'attack' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[18,22] (design) VisibilityModifier: Variable 'defence' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[19,22] (design) VisibilityModifier: Variable 'health' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[20,22] (design) VisibilityModifier: Variable 'speed' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[21,25] (design) VisibilityModifier: Variable 'description' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[22,22] (design) VisibilityModifier: Variable 'populationRequiredPerUnit' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[23,23] (design) VisibilityModifier: Variable 'baseSecondsToProduce' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[25,30] (design) VisibilityModifier: Variable 'plunderAmount' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[28,31] (design) VisibilityModifier: Variable 'resourcesRequiredToProduce' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[30,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[31,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Unit.java:[32,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[20,40] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[21,39] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[22,47] (coding) MagicNumber: '1000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[23,38] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[25,59] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[35,43] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[36,44] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[37,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/TransportShip.java:[42,3] (design) DesignForExtension: Class 'TransportShip' looks like designed for extension (can be subclassed), but the method 'getShipCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'TransportShip' final or making the method 'getShipCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[18,40] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[19,41] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[20,40] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[21,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[33,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Spear.java:[34,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[18,40] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[19,41] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[20,40] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[21,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[33,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Bow.java:[34,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[6,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[30,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[32,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[34,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[36,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[38,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[40,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[42,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[44,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[44,29] (misc) FinalParameters: Parameter unitToProduce should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[44,34] (coding) HiddenField: 'unitToProduce' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[44,49] (misc) FinalParameters: Parameter amountToProduce should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[44,53] (coding) HiddenField: 'amountToProduce' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[50] (sizes) LineLength: Line is longer than 80 characters (found 91).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[56,3] (design) DesignForExtension: Class 'UnitProductionItem' looks like designed for extension (can be subclassed), but the method 'produce' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UnitProductionItem' final or making the method 'produce' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[56,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[56,23] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[56,40] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[61,3] (design) DesignForExtension: Class 'UnitProductionItem' looks like designed for extension (can be subclassed), but the method 'addProductionToVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'UnitProductionItem' final or making the method 'addProductionToVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[61,41] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/UnitProductionItem.java:[61,58] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[18,40] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[19,41] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[20,40] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[21,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[33,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Scout.java:[34,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[18,40] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[19,41] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[20,40] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[21,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[33,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Axe.java:[34,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[16,55] (coding) MagicNumber: '610' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[18,40] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[19,41] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[20,40] (coding) MagicNumber: '40' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[21,39] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[26] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[30,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[37,43] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[38,43] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Shield.java:[39,44] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[15] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[16,55] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[18,40] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[20,40] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[21,39] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[22,47] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[23,38] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[25,59] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[35,43] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[36,44] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[37,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/BattleShip.java:[42,3] (design) DesignForExtension: Class 'BattleShip' looks like designed for extension (can be subclassed), but the method 'getShipCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'BattleShip' final or making the method 'getShipCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[15,39] (design) VisibilityModifier: Variable 'researchRequired' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[16,55] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[18,40] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[19,41] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[20,40] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[21,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[23] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[26,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[33,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/production/Jarl.java:[34,43] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/quests/Quest.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/quests/Quest.java:[7,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/quests/Quest.java:[9,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/quests/Quest.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/quests/Quest.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[7,17] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - java.util.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[8,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[11,54] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.entity.buildings.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[16,56] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - nl.duckstudios.pintandpillage.entity.researching.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[29,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[35,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[37,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[39,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[41,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[46,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[46,40] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[48] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[48,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[50,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[50,47] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[52,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[54,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[56,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[58,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[60,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[62,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[68,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[71,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[73] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[77,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[81,42] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[82,41] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[83,41] (coding) MagicNumber: '500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[87,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[90] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[90,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[94,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[96,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[98,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[100] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[104,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[106] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[110,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[112] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[114] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[116,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[118,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[120] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[125,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[127] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[132,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[141,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'createBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'createBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[141,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[141,30] (misc) FinalParameters: Parameter building should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[146,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'updateVillageState' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'updateVillageState' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[146,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[158,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'hasEnoughPopulation' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'hasEnoughPopulation' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[158,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[158,38] (misc) FinalParameters: Parameter population should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[158,42] (coding) HiddenField: 'population' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[162,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'hasEnoughPopulation' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'hasEnoughPopulation' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[162,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[162,38] (misc) FinalParameters: Parameter populationPerItem should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[162,61] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[166,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'addUnit' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'addUnit' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[166,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[166,23] (misc) FinalParameters: Parameter unit should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[166,34] (misc) FinalParameters: Parameter amountOfUnits should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[181,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'getUnitInVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'getUnitInVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[181,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[181,39] (misc) FinalParameters: Parameter unitType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[190,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'getResearchLevel' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'getResearchLevel' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[190,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[190,31] (misc) FinalParameters: Parameter researchType should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[199,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'addCompleteResearch' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'addCompleteResearch' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[199,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[199,35] (misc) FinalParameters: Parameter research should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[203,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'getPillageableResources' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'getPillageableResources' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[203,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[205] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[211,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'addReturnTravel' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'addReturnTravel' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[211,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[211,31] (misc) FinalParameters: Parameter returningCombatTravel should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[215,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'addToVillageLog' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'addToVillageLog' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[215,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[215,31] (misc) FinalParameters: Parameter timestamp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[215,56] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[225,3] (design) DesignForExtension: Class 'Village' looks like designed for extension (can be subclassed), but the method 'addToCombatLog' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Village' final or making the method 'addToCombatLog' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[225,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[225,30] (misc) FinalParameters: Parameter timestamp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[225,55] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[236] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[260] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[260,36] (coding) MagicNumber: '0.1f' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[285,29] (coding) MagicNumber: '9' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[285,32] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[286,29] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[286,32] (coding) MagicNumber: '7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[287,32] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[288,29] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[288,32] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[289,32] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[290,29] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[292,29] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[292,32] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[293,32] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[294,29] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[295,29] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[295,33] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[296,29] (coding) MagicNumber: '9' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[296,32] (coding) MagicNumber: '7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[297,29] (coding) MagicNumber: '14' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[297,33] (coding) MagicNumber: '7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[298,29] (coding) MagicNumber: '9' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[298,32] (coding) MagicNumber: '13' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[299,29] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[300,29] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[300,32] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[301,32] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[302,32] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[303,32] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[304,29] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[304,32] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[305,29] (coding) MagicNumber: '7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[305,32] (coding) MagicNumber: '13' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[306,29] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[306,33] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[307,29] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[307,32] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[308,29] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[308,32] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[309,29] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[309,33] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[310,29] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[335,26] (coding) HiddenField: 'resourcesPerHour' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[346] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[351] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[369] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:[373] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[6,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[30,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[32,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[32,17] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[32,18] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,15] (misc) FinalParameters: Parameter email should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,22] (coding) HiddenField: 'email' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,29] (misc) FinalParameters: Parameter username should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,36] (coding) HiddenField: 'username' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,46] (misc) FinalParameters: Parameter password should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/User.java:[34,53] (coding) HiddenField: 'password' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[14,36] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[15,71] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[20,43] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[21,44] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[22,43] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/JarlResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[14,36] (coding) MagicNumber: '20000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[15,39] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[20,43] (coding) MagicNumber: '8000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[21,44] (coding) MagicNumber: '8000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[22,43] (coding) MagicNumber: '8000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BattleShipResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[14,36] (coding) MagicNumber: '18000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[15,39] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[15,72] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[20,43] (coding) MagicNumber: '10000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[21,44] (coding) MagicNumber: '7000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[22,43] (coding) MagicNumber: '11000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/DefenceShipResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[14,36] (coding) MagicNumber: '7200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[15,39] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[20,43] (coding) MagicNumber: '1200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[21,44] (coding) MagicNumber: '1200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[22,43] (coding) MagicNumber: '1200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/AxeResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[14,36] (coding) MagicNumber: '13200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[15,39] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[20,43] (coding) MagicNumber: '4100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[21,44] (coding) MagicNumber: '4100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[22,43] (coding) MagicNumber: '4100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/BowResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[6,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[29] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[29,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[31,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[37,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[37,21] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/Research.java:[37,22] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[14,36] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[20,43] (coding) MagicNumber: '80' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[21,44] (coding) MagicNumber: '150' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[21,50] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[22,43] (coding) MagicNumber: '150' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[22,49] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/SpearResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[12,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[14,36] (coding) MagicNumber: '11800' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[15,39] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[20,43] (coding) MagicNumber: '2200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[21,44] (coding) MagicNumber: '2200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[22,43] (coding) MagicNumber: '2200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/researching/ShieldResearch.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[4,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[33,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[35,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[35,22] (misc) FinalParameters: Parameter unit should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[35,27] (coding) HiddenField: 'unit' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[35,33] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[35,37] (coding) HiddenField: 'amount' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[40,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[40,24] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/VillageUnit.java:[40,25] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[20,19] (misc) FinalParameters: Parameter seed should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[20,29] (misc) FinalParameters: Parameter xSize should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[20,40] (misc) FinalParameters: Parameter ySize should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[20,51] (misc) FinalParameters: Parameter maxIslandsAmount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[24,3] (design) DesignForExtension: Class 'WorldMap' looks like designed for extension (can be subclassed), but the method 'findEmptySpot' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldMap' final or making the method 'findEmptySpot' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[24,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[25,25] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[33] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[33,7] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[33,81] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[37] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[42] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[45,3] (design) DesignForExtension: Class 'WorldMap' looks like designed for extension (can be subclassed), but the method 'isValidToBuildNewVillage' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'WorldMap' final or making the method 'isValidToBuildNewVillage' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[45,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[45,43] (misc) FinalParameters: Parameter coord should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[48] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[49] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[52] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[52,30] (misc) FinalParameters: Parameter seed should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[52,40] (misc) FinalParameters: Parameter xSize should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[52,51] (misc) FinalParameters: Parameter ySize should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[52,62] (misc) FinalParameters: Parameter maxIslandsAmount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[77,41] (misc) FinalParameters: Parameter startX should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[77,53] (misc) FinalParameters: Parameter startY should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[84,9] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[94,35] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[94,42] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[95] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[98,31] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[98,38] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[99] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[102,39] (misc) FinalParameters: Parameter tile should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[102,50] (misc) FinalParameters: Parameter random should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[106,29] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[106,36] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[106,43] (misc) FinalParameters: Parameter random should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[106,58] (misc) FinalParameters: Parameter depth should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[107,5] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[109,17] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[113] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[113,44] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[115,7] (blocks) NeedBraces: 'if' construct must use '{}'s.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[126,31] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[126,38] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[127] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[130,32] (misc) FinalParameters: Parameter x should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[130,39] (misc) FinalParameters: Parameter y should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[134,39] (misc) FinalParameters: Parameter tile should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/WorldMap.java:[134,50] (misc) FinalParameters: Parameter amountOfWaterTiles should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/IStorable.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/IStorable.java:[4,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[13,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[15,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[21,3] (design) DesignForExtension: Class 'Mine' looks like designed for extension (can be subclassed), but the method 'resourcesProducedInGivenTime' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Mine' final or making the method 'resourcesProducedInGivenTime' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[21,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[21,43] (misc) FinalParameters: Parameter villageToAddResources should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[29,12] (coding) MagicNumber: '1000000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[32,3] (design) DesignForExtension: Class 'Mine' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Mine' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[35] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[35,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[35,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[35,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[41,51] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Mine.java:[41,56] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[12,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[19] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[22,3] (design) DesignForExtension: Class 'DefenceTower' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'DefenceTower' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[25,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[25,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[25,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[26,25] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[26,31] (coding) MagicNumber: '75' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[31] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[31,43] (coding) MagicNumber: '300' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[31,64] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[31,76] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[32,44] (coding) MagicNumber: '300' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[32,65] (coding) MagicNumber: '125' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[32,78] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[33] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[33,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[33,64] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[33,76] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[38,3] (design) DesignForExtension: Class 'DefenceTower' looks like designed for extension (can be subclassed), but the method 'getPopulationRequired' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'DefenceTower' final or making the method 'getPopulationRequired' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[39,36] (misc) FinalParameters: Parameter level should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[40,36] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:[43,3] (design) DesignForExtension: Class 'DefenceTower' looks like designed for extension (can be subclassed), but the method 'getDefenceBonus' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'DefenceTower' final or making the method 'getDefenceBonus' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[13,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[15,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[21,3] (design) DesignForExtension: Class 'Lumberyard' looks like designed for extension (can be subclassed), but the method 'resourcesProducedInGivenTime' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Lumberyard' final or making the method 'resourcesProducedInGivenTime' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[21,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[21,43] (misc) FinalParameters: Parameter villageToAddResources should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[29,12] (coding) MagicNumber: '1000000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[32,3] (design) DesignForExtension: Class 'Lumberyard' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Lumberyard' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[35] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[35,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[35,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[35,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[41,52] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:[41,57] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/IDefenceable.java:[4,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[14,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[19,42] (coding) MagicNumber: '750' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[22,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[27,3] (design) DesignForExtension: Class 'Headquarters' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Headquarters' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[30] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[30,9] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[30,16] (coding) MagicNumber: '45' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[30,86] (coding) MagicNumber: '1.75' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[31,51] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[31,56] (coding) MagicNumber: '40' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[37,53] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[37,58] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[37,64] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[38] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[38,59] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[38,64] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[38,78] (coding) MagicNumber: '0.5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[43,3] (design) DesignForExtension: Class 'Headquarters' looks like designed for extension (can be subclassed), but the method 'getPopulationCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Headquarters' final or making the method 'getPopulationCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[48,3] (design) DesignForExtension: Class 'Headquarters' looks like designed for extension (can be subclassed), but the method 'getPopulationRequired' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Headquarters' final or making the method 'getPopulationRequired' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[49,36] (misc) FinalParameters: Parameter level should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[50,13] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[50,33] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[50,55] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[53,3] (design) DesignForExtension: Class 'Headquarters' looks like designed for extension (can be subclassed), but the method 'getResourceCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Headquarters' final or making the method 'getResourceCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[58,3] (design) DesignForExtension: Class 'Headquarters' looks like designed for extension (can be subclassed), but the method 'updateVillageState' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Headquarters' final or making the method 'updateVillageState' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[60,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[64] (sizes) LineLength: Line is longer than 80 characters (found 99).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[68] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Headquarters.java:[68,29] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[12,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[14,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[19,3] (design) DesignForExtension: Class 'Smith' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Smith' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[21,38] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[26,43] (coding) MagicNumber: '1000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[26,50] (coding) MagicNumber: '60' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[27,44] (coding) MagicNumber: '150' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Smith.java:[27,50] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[12,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[21,3] (design) DesignForExtension: Class 'Storage' looks like designed for extension (can be subclassed), but the method 'getResourceCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Storage' final or making the method 'getResourceCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[26,3] (design) DesignForExtension: Class 'Storage' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Storage' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[28,38] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[28,42] (coding) MagicNumber: '30L' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[29,29] (coding) MagicNumber: '600' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[29,35] (coding) MagicNumber: '2500' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[34,59] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Storage.java:[34,65] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[11,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[26,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[28] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[32,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[34,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[36,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[38,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[41,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[44,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[46,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[48,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[48,35] (naming) MemberName: Name '_hasNotCollected' must match pattern '^[a-z][a-zA-Z0-9]*$'.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[50,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[50,31] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[50,32] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[52,3] (design) DesignForExtension: Class 'ProductionBuilding' looks like designed for extension (can be subclassed), but the method 'produceUnit' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ProductionBuilding' final or making the method 'produceUnit' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[52,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[52,27] (misc) FinalParameters: Parameter unit should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[52,38] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[55] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[63,3] (design) DesignForExtension: Class 'ProductionBuilding' looks like designed for extension (can be subclassed), but the method 'checkProduction' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ProductionBuilding' final or making the method 'checkProduction' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[63,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[68,38] (misc) FinalParameters: Parameter unit should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[68,49] (misc) FinalParameters: Parameter amount should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[70] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[72] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[75] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[80] (sizes) LineLength: Line is longer than 80 characters (found 94).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[84,27] (misc) FinalParameters: Parameter itemToAdd should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[86] (sizes) LineLength: Line is longer than 80 characters (found 82).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[91,40] (misc) FinalParameters: Parameter unitData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[94] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[97,40] (misc) FinalParameters: Parameter unitData should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[99] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[108] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[114] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[116] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[125] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ProductionBuilding.java:[145,3] (design) DesignForExtension: Class 'ProductionBuilding' looks like designed for extension (can be subclassed), but the method 'updateUnlockedUnitsData' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ProductionBuilding' final or making the method 'updateUnlockedUnitsData' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[17,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[19,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[25,3] (design) DesignForExtension: Class 'ResourceBuilding' looks like designed for extension (can be subclassed), but the method 'collectResources' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceBuilding' final or making the method 'collectResources' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[25,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[26] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[31,26] (coding) MagicNumber: '60' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[33] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[43] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[44] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:[55,3] (design) DesignForExtension: Class 'ResourceBuilding' looks like designed for extension (can be subclassed), but the method 'updateVillageState' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResourceBuilding' final or making the method 'updateVillageState' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[12,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[14,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[25,12] (coding) MagicNumber: '300' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[28,3] (design) DesignForExtension: Class 'Tavern' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Tavern' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[31] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[31,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[31,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[31,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[37,52] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Tavern.java:[37,57] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/IPopulatable.java:[4,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[18,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[24,31] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[28,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[40,42] (coding) MagicNumber: '4' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[41,45] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[42,42] (coding) MagicNumber: '13' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[43,43] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[46,3] (design) DesignForExtension: Class 'Barracks' looks like designed for extension (can be subclassed), but the method 'getProductionSpeed' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Barracks' final or making the method 'getProductionSpeed' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[46,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[47,16] (coding) MagicNumber: '0.1f' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[50,3] (design) DesignForExtension: Class 'Barracks' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Barracks' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[53] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[53,9] (coding) MagicNumber: '120' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[53,17] (coding) MagicNumber: '40' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[53,87] (coding) MagicNumber: '1.7' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[54,25] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[59] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[59,43] (coding) MagicNumber: '1000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[59,50] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[59,63] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[60] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[60,44] (coding) MagicNumber: '800' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[60,50] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:[60,63] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[12,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[25,46] (design) VisibilityModifier: Variable 'resourceManager' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[26,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[28,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[34,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[36,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[41,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[42,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[44,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[47,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[48,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[49,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[50,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[52,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[58,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[61,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[63,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[65,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[67,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[72,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'setConstructionTime' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'setConstructionTime' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[72,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[73] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[76,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'getConstructionTimeLeft' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'getConstructionTimeLeft' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[76,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[81] (sizes) LineLength: Line is longer than 80 characters (found 90).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[89,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'setConstructionTimeSeconds' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'setConstructionTimeSeconds' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[89,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[89,42] (misc) FinalParameters: Parameter seconds should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[94,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'levelUp' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'levelUp' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[94,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[97] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[101] (sizes) LineLength: Line is longer than 80 characters (found 85).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[104] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[106] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[109,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'updateBuildingState' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'updateBuildingState' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[109,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[112] (sizes) LineLength: Line is longer than 80 characters (found 86).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[112,27] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[112,61] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[117] (sizes) LineLength: Line is longer than 80 characters (found 97).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[120] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[124,3] (design) DesignForExtension: Class 'Building' looks like designed for extension (can be subclassed), but the method 'getPopulationRequired' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Building' final or making the method 'getPopulationRequired' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[124,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[124,36] (misc) FinalParameters: Parameter adjustment should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[125,13] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[125,32] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[125,49] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[128,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[131] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[134] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[140,39] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Building.java:[140,40] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[13,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[15,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[21,3] (design) DesignForExtension: Class 'Farm' looks like designed for extension (can be subclassed), but the method 'resourcesProducedInGivenTime' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Farm' final or making the method 'resourcesProducedInGivenTime' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[21,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[21,43] (misc) FinalParameters: Parameter villageToAddResources should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[29,12] (coding) MagicNumber: '1000000' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[32,3] (design) DesignForExtension: Class 'Farm' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Farm' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[35] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[35,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[35,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[35,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[41,52] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Farm.java:[41,57] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[27,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[32,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[32,29] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[32,30] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[34,3] (design) DesignForExtension: Class 'ResearchBuilding' looks like designed for extension (can be subclassed), but the method 'startResearch' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResearchBuilding' final or making the method 'startResearch' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[34,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[34,29] (misc) FinalParameters: Parameter research should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[42] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[43] (sizes) LineLength: Line is longer than 80 characters (found 95).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[48,44] (misc) FinalParameters: Parameter research should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[50] (sizes) LineLength: Line is longer than 80 characters (found 87).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[55] (sizes) LineLength: Line is longer than 80 characters (found 84).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[59] (sizes) LineLength: Line is longer than 80 characters (found 96).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[63,3] (design) DesignForExtension: Class 'ResearchBuilding' looks like designed for extension (can be subclassed), but the method 'updateVillageState' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'ResearchBuilding' final or making the method 'updateVillageState' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResearchBuilding.java:[74] (sizes) LineLength: Line is longer than 80 characters (found 89).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[11,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[11,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[13,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[17,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[22,3] (design) DesignForExtension: Class 'House' looks like designed for extension (can be subclassed), but the method 'getPopulationCapacity' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'House' final or making the method 'getPopulationCapacity' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[27,3] (design) DesignForExtension: Class 'House' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'House' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 100).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[32,18] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[32,62] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[32,76] (coding) MagicNumber: '1.32' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[37,43] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[37,48] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[37,61] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[38,44] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[38,48] (coding) MagicNumber: '20' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[38,61] (coding) MagicNumber: '6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[42] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[42,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[42,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[42,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[45,3] (design) DesignForExtension: Class 'House' looks like designed for extension (can be subclassed), but the method 'getPopulationRequired' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'House' final or making the method 'getPopulationRequired' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:[46,36] (misc) FinalParameters: Parameter level should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[18,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[24,31] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[25,29] (coding) MagicNumber: '10' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[26,24] (coding) MagicNumber: '8' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[30,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[42,3] (design) DesignForExtension: Class 'Harbor' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Harbor' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[44,38] (coding) MagicNumber: '5' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[45] (sizes) LineLength: Line is longer than 80 characters (found 93).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[52,43] (coding) MagicNumber: '200' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[52,49] (coding) MagicNumber: '15' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[53,44] (coding) MagicNumber: '400' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[53,50] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[54,43] (coding) MagicNumber: '250' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Harbor.java:[54,49] (coding) MagicNumber: '11' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[12,33] (design) VisibilityModifier: Variable 'name' must be private and have accessor methods.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[21,3] (design) DesignForExtension: Class 'Wall' looks like designed for extension (can be subclassed), but the method 'updateBuilding' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Wall' final or making the method 'updateBuilding' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[24] (sizes) LineLength: Line is longer than 80 characters (found 92).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[24,9] (coding) MagicNumber: '12' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[24,16] (coding) MagicNumber: '30' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[24,86] (coding) MagicNumber: '1.6' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[25] (sizes) LineLength: Line is longer than 80 characters (found 98).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[25,25] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[25,31] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[25,71] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[25,94] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[30] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[30,43] (coding) MagicNumber: '300' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[30,64] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[30,76] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[31] (sizes) LineLength: Line is longer than 80 characters (found 83).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[31,44] (coding) MagicNumber: '300' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[31,65] (coding) MagicNumber: '125' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[31,78] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[32] (sizes) LineLength: Line is longer than 80 characters (found 81).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[32,43] (coding) MagicNumber: '100' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[32,64] (coding) MagicNumber: '25' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[32,76] (coding) MagicNumber: '0.2' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[37,3] (design) DesignForExtension: Class 'Wall' looks like designed for extension (can be subclassed), but the method 'getPopulationRequired' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Wall' final or making the method 'getPopulationRequired' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[38,36] (misc) FinalParameters: Parameter level should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[39,36] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[39,41] (coding) MagicNumber: '50' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[39,54] (coding) MagicNumber: '3' is a magic number.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:[42,3] (design) DesignForExtension: Class 'Wall' looks like designed for extension (can be subclassed), but the method 'getDefenceBonus' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'Wall' final or making the method 'getDefenceBonus' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[5,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[23,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[25,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,18] (misc) FinalParameters: Parameter date should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,32] (coding) HiddenField: 'date' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,38] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,45] (coding) HiddenField: 'message' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,54] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/LogLine.java:[27,62] (coding) HiddenField: 'village' hides a field.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/CombatLog.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/CombatLog.java:[16,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/CombatLog.java:[16,20] (misc) FinalParameters: Parameter timestamp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/CombatLog.java:[16,45] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/CombatLog.java:[16,61] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/VillageLog.java:[15,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/VillageLog.java:[17,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/VillageLog.java:[17,21] (misc) FinalParameters: Parameter timestamp should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/VillageLog.java:[17,46] (misc) FinalParameters: Parameter message should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/logs/VillageLog.java:[17,62] (misc) FinalParameters: Parameter village should be final.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/ReturningCombatTravel.java:[1] (javadoc) JavadocPackage: Missing package-info.java file.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/ReturningCombatTravel.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/ReturningCombatTravel.java:[21,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/CombatTravel.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/CombatTravel.java:[18] (sizes) LineLength: Line is longer than 80 characters (found 88).
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[5,25] (imports) AvoidStarImport: Using the '.*' form of import should be avoided - javax.persistence.*.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[12,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[18,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[20,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[22,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/Travel.java:[24,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[14,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[16,3] (javadoc) JavadocVariable: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[18,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[18,31] (whitespace) WhitespaceAround: '{' is not followed by whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[18,32] (whitespace) WhitespaceAround: '}' is not preceded with whitespace.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[20,3] (design) DesignForExtension: Class 'AttackCombatTravel' looks like designed for extension (can be subclassed), but the method 'isJarlAttack' does not have javadoc that explains how to do that safely. If class is not designed for extension consider making the class 'AttackCombatTravel' final or making the method 'isJarlAttack' static/final/abstract/empty, or adding allowed annotation for the method.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[20,3] (javadoc) MissingJavadocMethod: Missing a Javadoc comment.
[ERROR] src/main/java/nl/duckstudios/pintandpillage/entity/travels/AttackCombatTravel.java:[22] (sizes) LineLength: Line is longer than 80 characters (found 84).
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.804 s
[INFO] Finished at: 2024-03-11T21:40:50+01:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-checkstyle-plugin:3.3.1:check (default-cli) on project pintandpillage: You have 1725 Checkstyle violations. -> [Help 1]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException


~/dev/pintandpillage-containerized/PintAndPillageJavaBackend > mvn spotless:apply                                                                          λ:main  [   ]
[INFO] Scanning for projects...
[INFO]
[INFO] -------------------< nl.duckstudios:pintandpillage >--------------------
[INFO] Building pintandpillage 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- spotless-maven-plugin:2.43.0:apply (default-cli) @ pintandpillage ---
[INFO] Spotless.Java is keeping 122 files clean - 0 were changed to be clean, 0 were already clean, 122 were skipped because caching determined they were already clean
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.456 s
[INFO] Finished at: 2024-03-11T21:43:36+01:00
[INFO] ------------------------------------------------------------------------
