package com.github.adamzv.backend.helpers.migrations;

import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.Region;
import com.github.adamzv.backend.model.Town;
import org.flywaydb.core.api.migration.Context;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

public class TownHelper {

    private final Context context;

    public TownHelper(Context context) {
        this.context = context;
    }

    public List<Container> saveAll(List<Container> containers) throws Exception {
        for (Container containerNew : containers) {
            containerNew.getAddress().setTown(findUniqueTown(containerNew.getAddress().getTown()));
        }
        return containers;
    }

    private Town findUniqueTown(Town townNew) throws Exception {
        try (Statement select = context.getConnection().createStatement()) {

            // find out if town already exits
            try (ResultSet rows = select.executeQuery("SELECT * FROM town WHERE town.town = '" + townNew.getTown() + "'")) {
                Town town = new Town();
                while (rows.next()) {
                    town.setId(rows.getLong(1));
                    town.setTown(rows.getString(2));

                    // create region object with id and insert it into the town
                    Region region = new Region();
                    region.setId(rows.getLong(3));
                    town.setRegion(region);
                }

                // if town exists, return it. Otherwise save new town and return that
                if (town.getId() != null) {
                    return town;
                } else {
                    return saveTown(townNew);
                }
            }
        }
    }

    private Town saveTown(Town townNew) throws Exception {
        try (Statement update = context.getConnection().createStatement()) {
            update.execute("INSERT INTO town VALUES (" + townNew.getId() + ", '" + townNew.getTown() + "', " + townNew.getRegion().getId() + " )", Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = update.getGeneratedKeys();
            rs.next();
            townNew.setId(rs.getLong(1));
            return townNew;
        }
    }
}