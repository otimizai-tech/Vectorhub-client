CREATE MIGRATION m1ergionknvg3urof3hdzmu4nsty2zi4cfkszgy2hizdybn4ecrhla
    ONTO m1fkzwmcvo2len3pd4h6eav3ifpmwpeqc7qpv6neerzblax5aetiwa
{
  ALTER TYPE default::Chunk {
      CREATE PROPERTY enabled: std::bool {
          SET default := true;
      };
      ALTER PROPERTY payload {
          SET TYPE std::json USING (<std::json>.payload);
      };
  };
};
