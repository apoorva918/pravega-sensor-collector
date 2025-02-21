/**
 * Copyright (c) Dell Inc., or its subsidiaries. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 */
package io.pravega.sensor.collector.file.rawfile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.io.CountingInputStream;
import io.pravega.sensor.collector.file.EventGenerator;
import io.pravega.sensor.collector.util.PravegaWriterEvent;
import org.apache.commons.lang3.tuple.Pair;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class RawEventGeneratorTests {
    private static final Logger LOG = LoggerFactory.getLogger(RawEventGeneratorTests.class);

    @Test
    public void testFile() throws IOException {
        final EventGenerator eventGenerator = RawEventGenerator.create("routingKey1");
        final String rawfileStr =
                "\"Time\",\"X\",\"Y\",\"Z\",\"IN_PROGRESS\"\n"
                + "\"2020-07-15 23:59:50.352\",\"0.305966\",\"0.0\",\"9.331963\",\"0\"\n"
                + "\"2020-07-15 23:59:50.362\",\"1.305966\",\"0.1\",\"1.331963\",\"0\"\n"
                + "\"2020-07-15 23:59:50.415\",\"0.305966\",\"0.0\",\"9.331963\",\"0\"\n";
        final CountingInputStream inputStream = new CountingInputStream(new ByteArrayInputStream(rawfileStr.getBytes(StandardCharsets.UTF_8)));
        final List<PravegaWriterEvent> events = new ArrayList<>();
        Pair<Long, Long> nextSequenceNumberAndOffset = eventGenerator.generateEventsFromInputStream(inputStream, 100, events::add);
        LOG.info("events={}", events);
        Assert.assertEquals(101L, (long) nextSequenceNumberAndOffset.getLeft());
        Assert.assertEquals(rawfileStr.length(), (long) nextSequenceNumberAndOffset.getRight());
    }

    @Test
    public void testEmptyFile() throws IOException {
        final EventGenerator eventGenerator = RawEventGenerator.create("routingKey1");
        final String rawfileStr = "";
        final CountingInputStream inputStream = new CountingInputStream(new ByteArrayInputStream(rawfileStr.getBytes(StandardCharsets.UTF_8)));
        final List<PravegaWriterEvent> events = new ArrayList<>();
        Pair<Long, Long> nextSequenceNumberAndOffset = eventGenerator.generateEventsFromInputStream(inputStream, 100, events::add);
        LOG.info("events={}", events);
        Assert.assertEquals(100L, (long) nextSequenceNumberAndOffset.getLeft());
        Assert.assertEquals(rawfileStr.length(), (long) nextSequenceNumberAndOffset.getRight());
    }


    @Test
    public void testCreateRawEventGeneratorWithNullRoutingKey() throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectNode objectNode = (ObjectNode) objectMapper.readTree("{}");
        Exception exception = Assert.assertThrows(NullPointerException.class, () -> new RawEventGenerator(null, objectNode, objectMapper));
        Assert.assertTrue("routingKey".equals(exception.getMessage()));
    }

    @Test
    public void testCreateRawEventGeneratorWithNullObjectMapper() throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectNode objectNode = (ObjectNode) objectMapper.readTree("{}");
        Exception exception = Assert.assertThrows(NullPointerException.class, () -> new RawEventGenerator("routing-key", objectNode, null));
        Assert.assertTrue("objectMapper".equals(exception.getMessage()));
    }
}
