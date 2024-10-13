CREATE MIGRATION m1slbggketewaoooage3afdfyy3nm6jd2ywydrhvsh6fl5wqupaxaq
    ONTO m122osibwan46j3dictd5oxwvm57e3op4wtgfowcfpntj5apyezygq
{
  ALTER TYPE default::Chunk {
      CREATE LINK hold_database: default::DataBaseHub;
  };
  ALTER TYPE default::DataBaseHub {
      CREATE LINK chunks := (.<hold_database[IS default::Chunk]);
  };
  ALTER TYPE default::Folder {
      ALTER PROPERTY path {
          RESET EXPRESSION;
          RESET CARDINALITY;
          RESET OPTIONALITY;
          SET TYPE std::str;
      };
      DROP PROPERTY path2;
  };
};
