/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hauschildt;

import java.time.LocalDate;
import java.util.Date;

/**
 *
 * @author k0519415
 */
public class Job implements Comparable<Job> {
    private int id;
    private boolean active;
    private LocalDate dateCreated;
    private String title;
    private String city;
    private String state;
    private boolean fullTime;
    private String department;
    private String experience;
    private String wageCategory;
    private double salary;
    
    public Job() {
        this.id = 0;
        this.active = false;
        this.dateCreated = LocalDate.now();
        this.title = "No title";
        this.city = "No city";
        this.state = "No state";
        this.fullTime = false;
        this.department = "No department";
        this.experience = "No experience";
        this.wageCategory = "No category";
        this.salary = 0;
    }

    public Job(int id, boolean active, LocalDate dateCreated, String title, String city, String state, boolean fullTime, String department, String experience, String wageCategory, double salary) {
        this.id = id;
        this.active = active;
        this.dateCreated = dateCreated;
        this.title = title;
        this.city = city;
        this.state = state;
        this.fullTime = fullTime;
        this.department = department;
        this.experience = experience;
        this.wageCategory = wageCategory;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public LocalDate getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDate dateCreated) {
        this.dateCreated = dateCreated;
    }
    
    public Date getNewDateCreated() {
        return java.sql.Date.valueOf(dateCreated);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public boolean isFullTime() {
        return fullTime;
    }

    public void setFullTime(boolean fullTime) {
        this.fullTime = fullTime;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getWageCategory() {
        return wageCategory;
    }

    public void setWageCategory(String wageCategory) {
        this.wageCategory = wageCategory;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    @Override
    public String toString() {
        return "Job{" + "title=" + title + ", location=" + city + ", " + state + ", department=" + department + ", active=" + active + '}';
    }

    @Override
    public int compareTo(Job other) {
        int result = this.dateCreated.compareTo(other.dateCreated);
        if(result == 0) {
            result = this.title.compareTo(other.title);
        }
        return result;
    }
    
}
