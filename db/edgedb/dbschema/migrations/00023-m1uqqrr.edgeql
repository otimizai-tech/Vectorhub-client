CREATE MIGRATION m1uqqrr2bkp22u234amtu2zfa3eygoyomigeinong4bjnjimwgggea
    ONTO m1slbggketewaoooage3afdfyy3nm6jd2ywydrhvsh6fl5wqupaxaq
{
  ALTER TYPE default::Chunk {
      CREATE PROPERTY database := (.hold_database.name);
  };
  ALTER TYPE default::Dashbord {
      ALTER LINK tags {
          RESET ON SOURCE DELETE;
      };
  };
};
