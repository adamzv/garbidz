package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.ScheduleNotFoundException;
import com.github.adamzv.backend.model.ContainerSchedule;
import com.github.adamzv.backend.model.Schedule;
import com.github.adamzv.backend.model.dto.ContainerScheduleDTO;
import com.github.adamzv.backend.repository.ScheduleRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import com.github.adamzv.backend.service.ScheduleService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/schedules")
public class ScheduleController {

    private ScheduleRepository scheduleRepository;
    private ScheduleService scheduleService;

    public ScheduleController(ScheduleRepository scheduleRepository, ScheduleService scheduleService) {
        this.scheduleRepository = scheduleRepository;
        this.scheduleService = scheduleService;
    }

    @GetMapping
    public Page<Schedule> getSchedule(@PageableDefault(size = 50) Pageable pageable) {
        return scheduleRepository.findAll(pageable);
    }

    @GetMapping("/user/{id}")
    public Page<ContainerSchedule> getSchedulesForUser(Pageable pageable, @PathVariable Long id) {
        return scheduleRepository.findAllSchedulesForUser(pageable, id);
    }

    @GetMapping("/{id}")
    public Schedule getSchedule(@PathVariable Long id) {
        return scheduleRepository.findById(id)
                .orElseThrow(() -> new ScheduleNotFoundException(id));
    }

    @PostMapping
    @IsModerator
    public ResponseEntity<Schedule> createScheduleForContainer(@RequestBody ContainerScheduleDTO scheduleDTO) {
        return ResponseEntity.ok(scheduleService.createScheduleForContainer(scheduleDTO));
    }

    @PutMapping("/{id}")
    @IsModerator
    public Schedule updateSchedule(@PathVariable Long id, @RequestBody Schedule newSchedule) {
        return scheduleRepository.findById(id)
                .map(schedule -> {
                    schedule.setDatetime(newSchedule.getDatetime());
                    schedule.setContainerSchedule(newSchedule.getContainerSchedule());
                    return scheduleRepository.save(schedule);
                })
                .orElseThrow(() -> new RuntimeException("Schedule with id " + id + " can not be updated!"));
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteSchedule(@PathVariable Long id) {
        scheduleRepository.deleteById(id);
    }

}
