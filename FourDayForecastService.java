package com.disaster.weather;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class FourDayForecastService {

    public Map<LocalDate, List<ForecastData>>
            groupIntoFourDays(
                    List<ForecastData> forecasts) {

        Map<LocalDate, List<ForecastData>> dailyData =
                new LinkedHashMap<>();

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern(
                        "yyyy-MM-dd HH:mm:ss"
                );

        for (ForecastData data : forecasts) {

            LocalDateTime dateTime =
                    LocalDateTime.parse(
                            data.getDateTime(),
                            formatter
                    );

            LocalDate date =
                    dateTime.toLocalDate();

            /*
             * Only keep maximum 4 different days
             */
            if (!dailyData.containsKey(date)
                    && dailyData.size() >= 4) {

                break;
            }

            dailyData
                    .computeIfAbsent(
                            date,
                            k -> new ArrayList<>()
                    )
                    .add(data);
        }

        return dailyData;
    }
}