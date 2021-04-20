package com.github.adamzv.backend.helpers.migrations;

import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.Region;
import org.flywaydb.core.api.migration.Context;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

public class RegionHelper {

    private final Context context;

    public RegionHelper(Context context) {
        this.context = context;
    }

    public List<Container> saveAll(List<Container> containers) throws Exception {
        for (Container containerNew : containers) {
            containerNew.getAddress().getTown().setRegion(findUniqueRegion(containerNew.getAddress().getTown().getRegion()));
        }
        return containers;
    }

    private Region findUniqueRegion(Region regionNew) throws Exception {
        try (Statement select = context.getConnection().createStatement()) {

            // find out if region already exits
            try (ResultSet rows = select.executeQuery("SELECT * FROM region WHERE region.region = '" + regionNew.getRegion() + "'")) {
                Region region = new Region();
                while (rows.next()) {
                    region.setId(rows.getLong(1));
                    region.setRegion(rows.getString(2));
                }

                // if region exists, return it. Otherwise save new region and return that
                if (region.getId() != null) {
                    return region;
                } else {
                    return saveRegion(regionNew);
                }
            }
        }
    }

    private Region saveRegion(Region regionNew) throws Exception {
        try (Statement update = context.getConnection().createStatement()) {
            update.execute("INSERT INTO region VALUES (" + regionNew.getId() + ", '" + regionNew.getRegion() + "')", Statement.RETURN_GENERATED_KEYS);

            // we need to add id of newly created region to the object
            ResultSet rs = update.getGeneratedKeys();
            rs.next();
            regionNew.setId(rs.getLong(1));
            return regionNew;
        }
    }
}
