CREATE MIGRATION m14rqr2vgoxk5257kmijekc7ertaegdiq67rixofbtkvuoi2jlioha
    ONTO m1cey3bd7tlqmhsqqwrmdj6orxhscc544xyh7skacqgtbztsd6zh7q
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY isEnabled {
          SET default := false;
      };
  };
};
