CREATE MIGRATION m1x6p4mqdyjcxgdlaylyyriaimtb3fbdlf332pcbex3qy3aqafi4ka
    ONTO m1km7tojndh3j3n4q3ahk6rumaisg7rhztea73rgq5lhme3zpipxnq
{
  ALTER TYPE default::Chunk {
      ALTER LINK database {
          ON TARGET DELETE ALLOW;
      };
  };
};
