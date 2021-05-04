package com.github.adamzv.backend.helpers.migrations;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.flywaydb.core.api.migration.Context;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ContainerScheduleHelper {

    private Context context;

    public ContainerScheduleHelper(Context context) {
        this.context = context;
    }

    public ContainerScheduleHelper() {
    }

    private Long id;

    @JsonProperty("date")
    private String date;

    @JsonProperty("garbageType")
    private String garbageType;

    @JsonProperty("addressName")
    private String addressName;

    public Context getContext() {
        return context;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getGarbageType() {
        return garbageType;
    }

    public void setGarbageType(String garbageType) {
        this.garbageType = garbageType;
    }

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }

    public void saveAll(List<ContainerScheduleHelper> containerSchedules) throws Exception {
        for (ContainerScheduleHelper containerSchedule : containerSchedules) {
            containerSchedule = insertSchedule(containerSchedule);
            List<Long> containersIds = getContainersIds(containerSchedule);
            insertScheduleToContainers(containerSchedule, containersIds);
        }
    }

    /**
     * Inserts new schedule into the database
     *
     * @param containerScheduleHelper containerScheduleHelper
     * @return ContainerScheduleHelper
     * @throws Exception e
     */
    public ContainerScheduleHelper insertSchedule(ContainerScheduleHelper containerScheduleHelper) throws Exception {
        try (Statement insert = context.getConnection().createStatement()) {
            insert.execute("INSERT INTO schedule (schedule.datetime) VALUES ('"
                    + containerScheduleHelper.getDate().toString() + "')", Statement.RETURN_GENERATED_KEYS);

            ResultSet rs = insert.getGeneratedKeys();
            rs.next();
            containerScheduleHelper.setId(rs.getLong(1));
            return containerScheduleHelper;
        }
    }

    /**
     * Returns containers ids according address and garbage type
     *
     * @param containerScheduleHelper containerScheduleHelper
     * @return List<Long>
     * @throws Exception e
     */
    public List<Long> getContainersIds(ContainerScheduleHelper containerScheduleHelper) throws Exception {
        try (Statement select = context.getConnection().createStatement()) {
            try (ResultSet rows = select.executeQuery("SELECT * FROM container INNER JOIN address ON address.id = container.id_address " +
                    "WHERE address.address = '" + containerScheduleHelper.getAddressName() + "' AND " +
                    "container.garbage_type = '" + containerScheduleHelper.getGarbageType() + "'")) {
                List<Long> containersId = new ArrayList<>();
                while (rows.next()) {
                    containersId.add(rows.getLong(1));
                }
                return containersId;
            }
        }
    }

    /**
     * Inserts schedule to found containers ids
     *
     * @param containerScheduleHelper containerScheduleHelper
     * @param containersIds
     * @throws Exception e
     */
    public void insertScheduleToContainers(ContainerScheduleHelper containerScheduleHelper, List<Long> containersIds) throws Exception {
        try (Statement insert = context.getConnection().createStatement()) {
            for (Long containersId : containersIds) {
                insert.execute("INSERT INTO container_has_schedule (container_has_schedule.id_container, container_has_schedule.id_schedule) VALUES ("
                        + containersId + ", " + containerScheduleHelper.getId() + ")");
            }
        }
    }
}
