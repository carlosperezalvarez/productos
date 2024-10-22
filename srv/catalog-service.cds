using com.sapas as sapas from '../db/schema';

service CatalogService {

        entity products as projection on sapas.products;
            
}