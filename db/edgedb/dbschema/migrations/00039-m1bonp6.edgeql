CREATE MIGRATION m1bonp6dp5ryhsetyoc5e4y6tpucm2uvbm7s4pyurkc3jwniqzzgfq
    ONTO m1kxuxirdim5l3ys6m2mdsml5iyixk6es5u55ovtcxypua5oh46jza
{
  CREATE GLOBAL default::current_collection -> std::uuid;
  ALTER TYPE default::Collection {
      CREATE ACCESS POLICY acess
          ALLOW ALL USING ((GLOBAL default::current_collection ?= .id));
  };
};
