package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.ScheduleNotFoundException;
import com.github.adamzv.backend.model.Schedule;
import com.github.adamzv.backend.repository.ScheduleRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/schedule")
public class ScheduleController {

    private ScheduleRepository scheduleRepository;

    public ScheduleController(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    @GetMapping
    public Page<Schedule> getSchedule(@PageableDefault(size = 50) Pageable pageable) {
            return scheduleRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Schedule getSchedule(@PathVariable Long id) {
            return scheduleRepository.findById(id)
                    .orElseThrow(() -> new ScheduleNotFoundException(id));
    }

    @PostMapping
    public Schedule newSchedule(@RequestBody Schedule schedule){
            schedule.setId(0L);
            return scheduleRepository.save(schedule);
    }

    @PutMapping("/{id}")
    public Schedule updateschedule(@PathVariable Long id, @RequestBody Schedule newSchedule) {
            return scheduleRepository.findById(id)
                    .map(schedule -> {
                        schedule.setDatetime(newSchedule.getDatetime());
                        schedule.setContainerSchedule(newSchedule.getContainerSchedule());
                        return scheduleRepository.save(schedule);
                    })
                    .orElseThrow(() -> new RuntimeException("Schedule with id " + id + " can not be updated!"));
    }

    @DeleteMapping("/{id}")
    public void deleteSchedule(@PathVariable Long id){
            scheduleRepository.deleteById(id);
    }

}
