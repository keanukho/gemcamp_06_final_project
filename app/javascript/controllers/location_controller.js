import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['selectedRegionId', 'selectProvinceId', 'selectCityId', 'selectBarangayId'];

    connect() {
        this.selectedRegionIdTarget.addEventListener('change', this.fetchProvinces.bind(this));
        this.selectProvinceIdTarget.addEventListener('change', this.fetchCities.bind(this));
        this.selectCityIdTarget.addEventListener('change', this.fetchBarangays.bind(this));
    }

    fetchProvinces() {
        let target = this.selectProvinceIdTarget;
        $(target).empty();

        $.ajax({
            type: 'GET',
            url: '/api/v1/regions/' + this.selectedRegionIdTarget.value + '/provinces',
            dataType: 'json',
            success: (response) => {
                console.log(response);
                $.each(response, function (index, record) {
                    let option = document.createElement('option');
                    option.value = record.id;
                    option.text = record.name;
                    target.appendChild(option);
                });
            },
            error: (error) => {
                console.error("Error fetching provinces:", error);
            }
        });
    }

    fetchCities() {
        let target = this.selectCityIdTarget;
        $(target).empty();

        $.ajax({
            type: 'GET',
            url: '/api/v1/provinces/' + this.selectProvinceIdTarget.value + '/cities',
            dataType: 'json',
            success: (response) => {
                console.log(response);
                $.each(response, function (index, record) {
                    let option = document.createElement('option');
                    option.value = record.id;
                    option.text = record.name;
                    target.appendChild(option);
                });
            },
            error: (error) => {
                console.error("Error fetching cities:", error);
            }
        });
    }

    fetchBarangays() {
        let target = this.selectBarangayIdTarget;
        $(target).empty();

        $.ajax({
            type: 'GET',
            url: '/api/v1/cities/' + this.selectCityIdTarget.value + '/barangays',
            dataType: 'json',
            success: (response) => {
                console.log(response);
                $.each(response, function (index, record) {
                    let option = document.createElement('option');
                    option.value = record.id;
                    option.text = record.name;
                    target.appendChild(option);
                });
            },
            error: (error) => {
                console.error("Error fetching barangays:", error);
            }
        });
    }
}
