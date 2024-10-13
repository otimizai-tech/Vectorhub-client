CREATE MIGRATION m1n5zcf23poqhuusqsjowicgtcsd2ku6obwggze6bp4d7c27p5tiga
    ONTO m1vaaztkxp44swe7jm65xziowjc2inq66esbuemnulunecfzehpgxa
{
  ALTER TYPE default::DataBaseHub {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (true);
  };
};
