CREATE MIGRATION m1xaq3m54g45nxbsqsageietky3h6t6ctyhf3ykzjhphww4rk2gopq
    ONTO m1wilnoif4nynoot2iw5hoyrgxjpvg2ikiaecxtgmksleuyz7uswuq
{
  ALTER TYPE default::Movie {
      CREATE PROPERTY title3: std::str;
  };
};
