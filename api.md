# Entrypoint: 

```POST /mcda```

```json
{
  "request_id": "fe0f48a6-c1f7-441b-b8ab-2095b53c67e9",
  "weights": [
    {
      "Utility_params": "u_gva_mey",
      "Value": 0.9
    },
    {
      "Utility_params": "u_gva_0.5mey",
      "Value": 0.5
    },
    {
      "Utility_params": "u_rber_1",
      "Value": 0
    },
    {
      "Utility_params": "u_rber_1.5",
      "Value": 0.7
    },
    {
      "Utility_params": "u_empl_ce",
      "Value": 0.5
    },
    {
      "Utility_params": "u_empl_0.5ce",
      "Value": 0.01
    },
    {
      "Utility_params": "u_wage_mnw",
      "Value": 0.5
    },
    {
      "Utility_params": "u_ssb_0.2",
      "Value": 0.01
    },
    {
      "Utility_params": "u_ssb_msy",
      "Value": 0.9
    },
    {
      "Utility_params": "u_f_msy",
      "Value": 0.9
    },
    {
      "Utility_params": "u_f_2msy",
      "Value": 0.2
    },
    {
      "Utility_params": "u_y_msy",
      "Value": 0.9
    },
    {
      "Utility_params": "u_y_0.5msy",
      "Value": 0.5
    },
    {
      "Utility_params": "u_d_0.25",
      "Value": 0.5
    },
    {
      "Utility_params": "u_d_0.5",
      "Value": 0.001
    },
    {
      "Utility_params": "GVA_or_ROI_or_PROFITS",
      "Value": "GVA"
    },
    {
      "Utility_params": "last_values",
      "Value": 3
    }
  ],
  "utility_params": [
    {
      "SuperDimension": "Socioeconomic",
      "Dimension": "Economic",
      "Name": "k_GVA_ROI",
      "Value": 0.008
    },
    {
      "SuperDimension": "Socioeconomic",
      "Dimension": "Economic",
      "Name": "k_RBER",
      "Value": 0.042
    },
    {
      "SuperDimension": "Socioeconomic",
      "Dimension": "Social",
      "Name": "k_WAGE",
      "Value": 0.064
    },
    {
      "SuperDimension": "Socioeconomic",
      "Dimension": "Social",
      "Name": "k_EMPL",
      "Value": 0.191
    },
    {
      "SuperDimension": "Biological",
      "Dimension": "Biological Conservation",
      "Name": "k_SSB",
      "Value": 0.26
    },
    {
      "SuperDimension": "Biological",
      "Dimension": "Biological Conservation",
      "Name": "k_F",
      "Value": 0.26
    },
    {
      "SuperDimension": "Biological",
      "Dimension": "Biological Production",
      "Name": "k_Y",
      "Value": 0.137
    },
    {
      "SuperDimension": "Biological",
      "Dimension": "Biological Production",
      "Name": "k_D",
      "Value": 0.036
    }
  ]
}
```