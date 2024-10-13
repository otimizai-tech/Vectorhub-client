CREATE MIGRATION m1vaaztkxp44swe7jm65xziowjc2inq66esbuemnulunecfzehpgxa
    ONTO m1fhodfklmabl7jy5g5mlkzaz67c65hfkqkx465z5ruodbun73slsq
{
  ALTER TYPE default::DataBaseHub {
      DROP ACCESS POLICY acess_collection_s;
  };
};
