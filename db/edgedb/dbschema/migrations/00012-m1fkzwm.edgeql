CREATE MIGRATION m1fkzwmcvo2len3pd4h6eav3ifpmwpeqc7qpv6neerzblax5aetiwa
    ONTO m13arorkfwsjawvfvnrs6xdwwd4mi2om22nxbeqvt4oonj5huexr7q
{
  ALTER TYPE default::File {
      ALTER PROPERTY enabled {
          SET default := true;
      };
  };
  ALTER TYPE default::Folder {
      ALTER PROPERTY enabled {
          SET default := true;
      };
  };
};
