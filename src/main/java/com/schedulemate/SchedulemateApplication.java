package com.schedulemate;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling // enable 스케줄링 기능
@SpringBootApplication
public class SchedulemateApplication {

	public static void main(String[] args) {
		SpringApplication.run(SchedulemateApplication.class, args);
	}

}
