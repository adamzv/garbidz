package com.github.adamzv.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.adamzv.backend.exception.GlobalControllerAdvice;
import com.github.adamzv.backend.exception.TownNotFoundException;
import com.github.adamzv.backend.model.Region;
import com.github.adamzv.backend.model.Town;
import com.github.adamzv.backend.repository.RegionRepository;
import com.github.adamzv.backend.repository.TownRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.List;
import java.util.Optional;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.core.Is.is;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.then;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.times;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class TownControllerTest {

    @Mock
    TownRepository townRepository;

    @Mock
    RegionRepository regionRepository;

    @InjectMocks
    TownController townController;

    MockMvc mockMvc;

    static Town town1;

    static Town town2;

    static Region region1;

    @BeforeAll
    static void beforeAll() {
        region1 = setupRegion();
        town1 = setupTown(1L, region1);
        town2 = setupTown(2L, region1);
    }

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(townController)
                .setControllerAdvice(GlobalControllerAdvice.class)
                .build();
    }

    @AfterEach
    void tearDown() {
        reset(townRepository);
        reset(regionRepository);
    }

    @Test
    void getTownsByRegionId() throws Exception {
        given(townRepository.findAllByRegionId(1L)).willReturn(List.of(town1, town2));

        mockMvc.perform(get("/towns?region_id={region_id}", 1))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$..[*].region.id", hasSize(2)))
                .andExpect(jsonPath("$[*].id", containsInAnyOrder(1, 2)));
    }

    @Test
    void getTownsFindAll() throws Exception {
        given(townRepository.findAll()).willReturn(List.of(town1, town2));

        mockMvc.perform(get("/towns"))
                .andExpect(status().isOk());
    }

    @Test
    void getTownFound() throws Exception {
        given(townRepository.findById(1L)).willReturn(Optional.of(town1));

        mockMvc.perform(get("/towns/{id}", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(1)))
                .andExpect(jsonPath("$.town", is("Nitra")))
                .andExpect(jsonPath("$.region.id", is(1)));
    }

    @Test
    void getTownNotFound() throws Exception {
        mockMvc.perform(get("/towns/{id}", 2)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(result -> assertTrue(result.getResolvedException() instanceof TownNotFoundException))
                .andExpect(jsonPath("$.message", is("Could not find town with id: 2")))
                .andExpect(jsonPath("$.status", is("NOT_FOUND")));
    }

    // TODO region not found
    @Test
    void newTown() throws Exception {
        given(regionRepository.findById(1L)).willReturn(Optional.of(region1));
        given(townRepository.save(any())).willReturn(town2);

        ObjectMapper mapper = new ObjectMapper();
        String newTown = mapper.writeValueAsString(town1);

        mockMvc.perform(post("/towns")
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .content(newTown))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(2)))
                .andExpect(jsonPath("$.town", is("Nitra")));

        then(townRepository).should(times(1)).save(any(Town.class));
    }

    // TODO town id not found, region id not found
    @Test
    void updateTown() throws Exception {
        Town town3 = new Town();
        town3.setRegion(region1);
        town3.setId(1L);
        town3.setTown("Nitra - Chrenová");
        given(townRepository.findById(1L)).willReturn(Optional.of(town1));
        given(regionRepository.findById(1L)).willReturn(Optional.of(region1));
        given(townRepository.save(any())).willReturn(town3);

        ObjectMapper mapper = new ObjectMapper();

        mockMvc.perform(put("/towns/{id}", 1L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .accept(MediaType.APPLICATION_JSON)
                        .content(mapper.writeValueAsString(town3)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(1)))
                .andExpect(jsonPath("$.town", is("Nitra - Chrenová")));

        then(townRepository).should(times(1)).save(any());
    }

    @Test
    void deleteTown() throws Exception {
        mockMvc.perform(delete("/towns/{id}", 1L))
                .andExpect(status().isOk())
                .andExpect(content().string(""));
        then(townRepository).should(times(1)).deleteById(1L);
    }

    private static Town setupTown(Long id, Region region) {
        Town result = new Town();
        result.setTown("Nitra");
        result.setId(id);
        result.setRegion(region);
        return result;
    }

    private static Region setupRegion() {
        Region region = new Region();
        region.setId(1L);
        region.setRegion("Nitriansky");
        return region;
    }
}