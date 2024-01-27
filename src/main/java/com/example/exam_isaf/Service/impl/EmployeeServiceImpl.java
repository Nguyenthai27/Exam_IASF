package com.example.exam_isaf.Service.impl;

import com.example.exam_isaf.Repository.EmployeeRepository;
import com.example.exam_isaf.Service.EmployeeService;
import com.example.exam_isaf.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeRepository _employeeRepository;
    @Override
    public void createEmployee(Employee employee) {
        try {
            _employeeRepository.save(employee);
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

    @Override
    public List<Employee> findAllEmployees() {
        return _employeeRepository.findAll();
    }
}
