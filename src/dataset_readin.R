
measure = read_csv(here("data", "analysis/size_master.csv"))
harvest = read_csv(here("data", "analysis/harvest_metrics.csv")) 
health = read_csv(here("data", "analysis/ndvi_data.csv"))
harvest_tips = read_csv(here("data", "analysis/harvest_roottips - all.csv"))
repot_tips = read_csv(here("data", "repotting/ghecto_repotting_root_pulling_data.csv"))
repot_mass = read_csv(here("data", "repotting", "repotting_drymass_fitted.csv"))
harvest_mass = read_csv(here("data", "harvest", "harvest_biomass_wideclean.csv"))
image_data = read_csv(here("data", "wide_final_seedling_area.csv"))
neighb_pairs = read_csv(here("data", "design", "ghecto_neighbor_pairs.csv"))
trt = read_csv(here("data", "design", "seedling_treatments.csv"))
drought = read_csv(here("data", "design", "drought_assignments_bypot.csv")) %>% 
  select(1,3)
harvest_comm = read_csv( here("data", "harvest", "harvest_community_matrix_scaled.csv"))

pressure = read_csv(here("data/harvest", "pressure_bomb - Sheet1.csv")) %>% 
  select(1:4) %>%  mutate(time = tolower(time))
sapwood = read_csv(here("data/harvest", "harvest_sapwood.csv"))

colonization = repot_tips %>% 
  mutate(repot_col = colonization_numerator/colonization_denominator) %>% 
  select(seedling_id, repot_col) %>% 
  left_join(harvest_tips %>% mutate(harvest_col = colonized/(colonized+uncolonized)) %>% 
              select(seedling_id, harvest_col) %>% 
              mutate(seedling_id = as.numeric(seedling_id)))

drought_treat = health %>% 
  select(seedling_id, treatment) %>% distinct()

total_treat = measure %>% 
  select(seedling_id, seedling_sp, soil_type, neighbor, neighb_sp, neighb_st, pot) %>% distinct() %>% drop_na() %>% 
  left_join(drought_treat)%>% 
  mutate(soil_type = fct_relevel(soil_type, "P", "Q", "C"))

image_df = image_data %>% left_join(total_treat) %>% 
  mutate(total_foliar = foliar+predawn_foliar+midday_foliar) %>% 
  left_join(drought_treat)

sort_string_chars <- function(s) {
  paste(sort(unlist(strsplit(s, ""))), collapse = "")
}

pot_df = neighb_pairs %>% 
  rename(seedling_id = seedling_1) %>% 
  left_join(trt) %>% 
  rename(sp1 = seedling_sp, st1 = soil_type) %>% 
  select(!seedling_id) %>% 
  rename(seedling_id = seedling_2) %>% 
  left_join(trt)%>% 
  rename(sp2 = seedling_sp, st2 = soil_type) %>% 
  mutate(spp = paste0(sp1, sp2))%>% 
  mutate(stt = paste0(st1, st2)) %>% 
  select(pot, spp, stt) %>% 
  mutate(spp = map_chr(spp, sort_string_chars)) %>% #alphabetize the combo to minimize different uniques
  mutate(stt = map_chr(stt, sort_string_chars)) %>% 
  left_join(drought)

masschange = repot_mass %>% 
  rename(r_root = below_dry, r_shoot = above_dry) %>% 
  left_join(harvest_mass %>% 
              mutate(shoot = shoot+foliar) %>% 
              select(-foliar) %>% 
              rename(h_shoot = shoot, h_root = root)) %>% 
  mutate(d_root = h_root/r_root, d_shoot = h_shoot/r_shoot, d_total = (h_root+h_shoot)/(r_root+r_shoot)) %>% 
  left_join(total_treat)%>%
  mutate(nst_long = case_when(
    neighb_st == "P" ~ "Neighbor Bigcone soil",
    neighb_st == "Q" ~ "Neighbor Oak soil",
    neighb_st == "C" ~ "Neighbor Sterile soil"
  ))%>% 
  mutate(nsp_long = case_when(
    neighb_sp == "P" ~ "Neighbor Bigcone",
    neighb_sp == "Q" ~ "Neighbor Oak"
  )) %>% 
  left_join(drought_treat)%>% 
  filter(!is.na(h_shoot))%>% 
  mutate(soil_type = fct_relevel(soil_type, "P", "Q", "C"))

living = measure %>% 
  filter(date == "2022-04-01") %>% 
  filter(alive ==1) %>% 
  filter(neighb_alive == 1) %>% 
  select(seedling_id)
