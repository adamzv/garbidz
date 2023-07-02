package db.migration;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.adamzv.backend.helpers.migrations.ContainerScheduleHelper;
import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

public class V1_2_7__extract_containers_schedules extends BaseJavaMigration {

    @Override
    public void migrate(Context context) throws Exception {

        // Create helpers for storing containers data
        ContainerScheduleHelper containerScheduleHelper = new ContainerScheduleHelper(context);

        // list of all schedule json files
        List<String> filesList = Arrays.asList(
                "paper_cardboard_schedule",
                "plastic_glass_schedule",
                "mixed_packaging_schedule",
                "municipal_waste_schedule",
                "municipal_waste_schedule_2",
                "biowaste_schedule",
                "biowaste_schedule_2");

        // read json and write to db
        ObjectMapper mapper = new ObjectMapper();
        TypeReference<List<ContainerScheduleHelper>> typeReference = new TypeReference<List<ContainerScheduleHelper>>() {
        };
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        try {
            for (String file : filesList) {
                InputStream inputStream = classloader.getResourceAsStream("json/" + file + ".json");
                List<ContainerScheduleHelper> containers = mapper.readValue(inputStream, typeReference);
                containerScheduleHelper.saveAll(containers);
            }
        } catch (IOException e) {
            System.out.println("Unable to save containers schedule data: " + e.getMessage());
        }
    }
}
