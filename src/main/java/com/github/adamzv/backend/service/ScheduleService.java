package com.github.adamzv.backend.service;

import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.ContainerSchedule;
import com.github.adamzv.backend.model.Schedule;
import com.github.adamzv.backend.model.dto.ContainerScheduleDTO;
import com.github.adamzv.backend.repository.ContainerRepository;
import com.github.adamzv.backend.repository.ContainerScheduleRepository;
import com.github.adamzv.backend.repository.ScheduleRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ScheduleService {

    private ScheduleRepository scheduleRepository;
    private ContainerRepository containerRepository;
    private ContainerScheduleRepository containerScheduleRepository;

    public ScheduleService(ScheduleRepository scheduleRepository, ContainerRepository containerRepository, ContainerScheduleRepository containerScheduleRepository) {
        this.scheduleRepository = scheduleRepository;
        this.containerRepository = containerRepository;
        this.containerScheduleRepository = containerScheduleRepository;
    }

    public Schedule createScheduleForContainer(ContainerScheduleDTO scheduleDTO) {
        Schedule schedule = new Schedule(scheduleDTO.getDate());
        schedule = scheduleRepository.save(schedule);

        Set<Container> containers = containerRepository.findAllByAddress_Id(scheduleDTO.getAddressId());
        Schedule finalSchedule = schedule;
        containers.stream()
                .filter(container -> container.getGarbageType().equals(scheduleDTO.getGarbageType()))
                .collect(Collectors.toList())
                .forEach(container -> {
                    ContainerSchedule containerSchedule = new ContainerSchedule(container, finalSchedule);
                    containerScheduleRepository.save(containerSchedule);
                });

        return schedule;
    }
}
