CREATE MIGRATION m1kxuxirdim5l3ys6m2mdsml5iyixk6es5u55ovtcxypua5oh46jza
    ONTO m1jvxlcmvtaav32dslmn6vzcs3tfh7ee4hta5qu7s4exnhln7g6xma
{
  ALTER TYPE default::Chunk {
      ALTER LINK database {
          SET MULTI;
      };
  };
};
