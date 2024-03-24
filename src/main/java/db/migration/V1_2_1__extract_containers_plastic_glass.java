package db.migration;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.adamzv.backend.helpers.migrations.*;
import com.github.adamzv.backend.model.Container;
import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class V1_2_1__extract_containers_plastic_glass extends BaseJavaMigration {

    @Override
    public void migrate(Context context) throws Exception {

        // Create helpers for storing containers data
        ContainerTypeHelper containerTypeHelper = new ContainerTypeHelper(context);
        RegionHelper regionHelper = new RegionHelper(context);
        TownHelper townHelper = new TownHelper(context);
        AddressHelper addressHelper = new AddressHelper(context);
        ContainerHelper containerHelper = new ContainerHelper(context);

        // read json and write to db
        ObjectMapper mapper = new ObjectMapper();
        TypeReference<List<Container>> typeReference = new TypeReference<List<Container>>() {
        };
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        InputStream inputStream = classloader.getResourceAsStream("json/plastic_glass.json");
        try {
            List<Container> containers = mapper.readValue(inputStream, typeReference);

            containers = containerTypeHelper.saveAll(containers);
            containers = regionHelper.saveAll(containers);
            containers = townHelper.saveAll(containers);
            containers = addressHelper.saveAll(containers);
            containerHelper.saveAll(containers);
        } catch (IOException e) {
            System.out.println("Unable to save plastic and glass containers data: " + e.getMessage());
        }
    }
}