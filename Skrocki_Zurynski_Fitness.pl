%PROJEKT FITNESS
% Cwiczenia
% Cwiczenie(nazwa, typ, spalone kalorie na godzine).
cwiczenie(bieganie, kardio, 600).
cwiczenie(jazda_na_rowerze, kardio, 500).
cwiczenie(pompki, sila, 300).
cwiczenie(przysiady, sila, 350).
cwiczenie(joga, elastycznosc, 200).
cwiczenie(plywanie, kardio, 700).
cwiczenie(skakanka,kardio,600).
cwiczenie(martwy_ciag,sila,400).
cwiczenie(wyciskanie_sztangi,sila,450).
cwiczenie(rozciaganie,elastycznosc,150).
cwiczenie(pilates,elastycznosc,250).
cwiczenie(boks,kardio,750).
cwiczenie(spinning,kardio,550).
cwiczenie(trening_obwodowy,sila,600).
cwiczenie(zumba,kardio,400).
cwiczenie(bieg_w_miejscu,kardio,650).
cwiczenie(podciaganie_na_drazku,sila,300).
cwiczenie(wyciskanie_hantli,sila,400).

%Cele Fitness
%cel(nazwa,typ,opis)
cel(utrata_wagi,_,'Redukcja masy ciala przez deficyt kaloryczny').
cel(zbudowanie_miesni,sila,'Budowanie masy miesniowej przez cwiczenia silowe').
cel(poprawa_kondycji,kardio,'Poprawa wydolnosci przez cwiczenia kardio').
cel(poprawa_elastycznosci,elastycznosc,'Poprawa zakresu ruchu przez cwiczenia rozciagajace').

%Regula pokazująca najlepsze cwiczenia dla danego celu
najlepsze_cwiczenie(Cel, Cwiczenie) :-
    cel(Cel,Typ,_),
    cwiczenie(Cwiczenie,Typ,_).

%Regula pokazująca ilość spalonych kalorii przez dane cwiczenie
spalone_kalorie(Cwiczenie, Kalorie) :-
    cwiczenie(Cwiczenie, _, KalorieNaGodzine),
    Kalorie is KalorieNaGodzine.
%Regula pokazująca wszystkie cwiczenia
wszystkie_cwiczenia(ListaCwiczen) :-
    findall(Nazwa, cwiczenie(Nazwa,_,_), ListaCwiczen).
%Regula pokazująca typ cwiczenia
typ_cwiczenia(Nazwa,Typ) :-
    cwiczenie(Nazwa, Typ, _).

%Cwiczenia na dane partie ciala
cwiczenie_na(klata,pompki).
cwiczenie_na(klata,wyciskanie_sztangi_na_lawce).
cwiczenie_na(klata,rozpietki).
cwiczenie_na(klata,dipy).
cwiczenie_na(nogi,przysiady).
cwiczenie_na(nogi,przysiad_ze_sztanga).
cwiczenie_na(nogi,wykroki).
cwiczenie_na(nogi,hipthrust).
cwiczenie_na(plecy,martwy_ciag).
cwiczenie_na(plecy,wioslowanie).
cwiczenie_na(plecy,wioslowanie_na_wyciagu).
cwiczenie_na(plecy,podciaganie_na_drazku).
cwiczenie_na(plecy,sciaganie_drazka_wyciagu_gornego).
cwiczenie_na(biceps,wyciskanie_hantli).
cwiczenie_na(biceps,uginanie_ramion_na_wyciagu).
cwiczenie_na(biceps,uginanie_ramion_na_modlitewniku).
cwiczenie_na(biceps,wyciskanie_hantli_mlotkowe).
cwiczenie_na(triceps,dipy).
cwiczenie_na(triceps,wciaganie_drazka_wyciag_gorny).
cwiczenie_na(brzuch,brzuszki).
cwiczenie_na(brzuch,plank).

%Regula wyswietla cwiczenia dla danej grupy miesniowej
cwiczenie_dla_grupy_miesniowej(CwiczenieNa,GrupaMiesniowa):-
    cwiczenie_na(GrupaMiesniowa,CwiczenieNa).

%Regula pudzian
pudzian(wyciskanie_na_klate,295).
pudzian(przysiad,395).
pudzian(martwy_ciag,415).

% Regula sprawdzajaca czy wartosci podane przez uzytkownika sa zgodne z
% wymaganiami pudziana
czy_pudzian(Wyciskanie,Przysiad,MartwyCiag):-
    pudzian(wyciskanie_na_klate,Wyciskanie),
    pudzian(przysiad,Przysiad),
    pudzian(martwy_ciag,MartwyCiag).

%Sprawdzenie poprawnosci chlopa
chlop(wyciskanie_na_klate,150).
chlop(przysiad,180).
chlop(martwy_ciag,200).

czy_chlop(Wyciskanie,Przysiad,MartwyCiag):-
    chlop(wyciskanie_na_klate,Wyciskanie),
    chlop(przysiad,Przysiad),
    chlop(martwy_ciag,MartwyCiag).

%Kluczowa informacja
czy_biegam_wolniej_od_kiwi(Predkosc):-
    Predkosc<19.

%Oblicza minimalny ciezar dla wyciskania na klate wedlug Brzyckiego.
max_wyciskanie(Waga, Ciezar) :-
    Ciezar is Waga * 0.75.

%Oblicza minimalny ciezar dla przysiadu wedlug Brzyckiego.
max_przysiad(Waga, Ciezar) :-
    Ciezar is Waga * 0.8.

%Oblicza minimalny ciezar dla martwego ciagu wedlug Brzyckiego.
max_martwy_ciag(Waga, Ciezar) :-
    Ciezar is Waga * 1.0.


% Regula wyswietlajaca wyniki wyciskania, przysiadu i martwego ciagu dla
% podanej wagi
wyswietl_wyniki(Waga, CiezarWyciskanie, CiezarPrzysiad, CiezarMartwyCiag) :-
    max_wyciskanie(Waga,CiezarWyciskanie),
    max_przysiad(Waga,CiezarPrzysiad),
    max_martwy_ciag(Waga,CiezarMartwyCiag).

% Regula obliczajaca wskaznik BMI z komentarzem.
bmi(Waga, Wzrost, BMI, Komentarz) :-
    BMIRaw is Waga / ((Wzrost / 100) * (Wzrost / 100)),
    BMI is round(BMIRaw * 100) / 100, % Zaokraglenie do dwoch miejsc po przecinku
    (BMI < 18.5 -> Komentarz = 'Niedowaga';
    BMI >= 18.5, BMI < 24.9 -> Komentarz = 'W normie';
    BMI >= 24.9, BMI < 29.9 -> Komentarz = 'Nadwaga';
    BMI >= 29.9 -> Komentarz = 'Otylosc').

%Regula sprawdzajaca czy uda ci sie uciec przed wscieklym leniwcem.
ucieczka_przed_leniwcem(Prędkość) :-
    Prędkość > 0.5,
    writeln('Twoje bieganie sprawi, ze bedziesz mogl uciec przed wscieklym leniwcem!').

%Regula sprawdzajaca czy jestes w stanie wygrac z szopem praczem.
wygrana_w_arm_wrestling(Obwod_bicepsu) :-
    Obwod_bicepsu >15,
    writeln('Twoje bicepsy sa gotowe na arm wrestling z szopem praczem!').

%Regula sprawdzajaca czy uda nam sie zlapac tuktuka w Indiach
zlap_autobus(Prędkość) :-
    Prędkość > 5,
    writeln('Masz szanse zlapac uciekajacego tuktuka!').

%Regula sprawdzajaca czy jestesmy szybszy niz przecietne zombie.
szybszy_od_zombie(Prędkość) :-
    Prędkość > 3,
    writeln('Jestes szybszy niz zombie, gratulacje!').


% Regula obliczania zapotrzebowania kalorycznego (CPM) z korekcja masy
% ciala

oblicz_zapotrzebowanie_kaloryczne(Waga, Wzrost, Wiek, Plec, Aktywnosc, CPM) :-

    % Oblicz PPM (podstawowa przemiana materii)
    oblicz_ppm(Waga, Wzrost, Wiek, Plec, PPM),

    % Oblicz wspolczynnik korekcji masy ciala
    oblicz_k(Waga, K),

    % Oblicz skorygowana PPM
    PPM_skorygowane is PPM * K,

    % Oblicz wspolczynnik aktywnosci fizycznej (PAL)
    oblicz_pal(Aktywnosc, PAL),

    % Oblicz CPM (calkowita przemiana materii)
    CPM is PPM_skorygowane * PAL.


oblicz_ppm(Waga, Wzrost, Wiek, Plec, PPM) :-
    (Plec = kobieta) ->
        PPM is 655 + (9.6 * Waga) + (1.8 * Wzrost) - (4.7 * Wiek);
    (Plec = mezczyzna) ->
        PPM is 88 + (13.4 * Waga) + (4.8 * Wzrost) - (5.68 * Wiek).

oblicz_k(Waga, K) :-
    Waga < 50 -> K = 0.9;
    Waga >= 50, Waga < 60 -> K = 0.95;
    Waga >= 60, Waga < 70 -> K = 1.0;
    Waga >= 70, Waga < 80 -> K = 1.05;
    Waga >= 80, Waga < 90 -> K = 1.1;
    Waga >= 90 -> K = 1.15.

oblicz_pal(niska, 1.05).
oblicz_pal(umiarkowana, 1.2).
oblicz_pal(wysoka, 1.35).
oblicz_pal(bardzo_wysoka, 1.525).
oblicz_pal(ekstremalnie_wysoka, 1.7).









