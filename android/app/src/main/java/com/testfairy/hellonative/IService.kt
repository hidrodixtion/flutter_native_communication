package com.testfairy.hellonative

import retrofit2.Call
import retrofit2.http.GET

/**
 * Created by adinugroho
 */
interface IService {
    @GET("search_all_teams.php?l=English Premier League")
    fun getEPLTeams(): Call<TeamResponse>
}