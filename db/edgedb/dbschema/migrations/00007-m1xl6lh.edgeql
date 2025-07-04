CREATE MIGRATION m1xl6lhv2rixz45aoie57qx7faswxgbwxm7eotgk47u6iauemdhaoa
    ONTO m1x6p4mqdyjcxgdlaylyyriaimtb3fbdlf332pcbex3qy3aqafi4ka
{
  ALTER TYPE default::Chunk {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::Collection {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::Dashbord {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::DataBaseHub {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::File {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::Folder {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::Prompt {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
  ALTER TYPE default::Tag {
      CREATE REQUIRED PROPERTY X_alias: std::str {
          SET default := (<std::str>std::uuid_generate_v4());
      };
  };
};
